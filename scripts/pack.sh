#!/usr/bin/env bash
# Pack the km-baseline preset into a versioned ZIP for GitHub Release.
#
#   ./scripts/pack.sh            # pack + verify catalog.json sync
#   ./scripts/pack.sh --release  # above + git tag + push + gh release create
#
# Output: dist/km-baseline-<version>.zip
# Archive layout: top-level dir "km-baseline/" containing preset.yml + commands/.
# This matches what `specify preset add --from <url>` expects (preset.yml at
# the archive root or one dir below it).
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRESET_DIR="$REPO_ROOT/presets/km-baseline"
DIST_DIR="$REPO_ROOT/dist"
CATALOG="$REPO_ROOT/catalog.json"
RELEASE=0

if [[ "${1:-}" == "--release" ]]; then
  RELEASE=1
fi

if [[ ! -f "$PRESET_DIR/preset.yml" ]]; then
  echo "error: preset.yml not found at $PRESET_DIR" >&2
  exit 1
fi

# Read version from preset.yml:  version: "1.1.0"
VERSION="$(awk -F'"' '/^  version:/{print $2}' "$PRESET_DIR/preset.yml")"
if [[ -z "$VERSION" ]]; then
  echo "error: could not read version from preset.yml" >&2
  exit 1
fi

TAG="v$VERSION"
ZIP="$DIST_DIR/km-baseline-$VERSION.zip"
mkdir -p "$DIST_DIR"

# Build a clean archive with km-baseline/ as the top-level directory.
# Uses a temp staging copy so stray files in presets/km-baseline are excluded.
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT
cp -R "$PRESET_DIR" "$STAGE/km-baseline"

( cd "$STAGE" && zip -r -X "$ZIP" km-baseline ) >/dev/null

echo "packed: $ZIP"
unzip -l "$ZIP"

# --- Verify catalog.json is in sync with preset.yml (must pass for --release) ---
CATALOG_OK=0
if [[ -f "$CATALOG" ]]; then
  if python3 - "$CATALOG" "$VERSION" << 'PYEOF'
import json, re, sys
catalog_path, version = sys.argv[1], sys.argv[2]
expected_tag = "v" + version
with open(catalog_path) as f:
    data = json.load(f)
pack = data.get("presets", {}).get("km-baseline", {})
cat_version = pack.get("version", "")
cat_url = pack.get("download_url", "") or ""
problems = []
fixed_url = cat_url
if cat_version != version:
    problems.append(f"  version: catalog={cat_version!r}  preset={version!r}")
m = re.search(r"/download/([^/]+)/", cat_url)
cat_tag = m.group(1) if m else ""
if cat_tag != expected_tag:
    fixed_url = re.sub(r"/download/[^/]+/", f"/download/{expected_tag}/", cat_url)
    fixed_url = re.sub(r"/km-baseline-[^/]+\.zip$", f"/km-baseline-{version}.zip", fixed_url)
    problems.append(f"  download_url tag: catalog={cat_tag!r}  expected={expected_tag!r}")
if problems:
    print("[WARN] catalog.json is out of sync with preset.yml:", file=sys.stderr)
    for p in problems:
        print(p, file=sys.stderr)
    print(f"  fix catalog.json: version={version!r}, download_url={fixed_url!r}", file=sys.stderr)
    print("  ZIP is already built; just edit catalog.json and commit.", file=sys.stderr)
    sys.exit(1)
else:
    print(f"[OK] catalog.json in sync (version={version}, tag={expected_tag})")
PYEOF
  then
    CATALOG_OK=1
  else
    CATALOG_OK=0
  fi
else
  echo "[WARN] catalog.json not found at $CATALOG -- skipping sync check" >&2
fi

if [[ $RELEASE -eq 0 ]]; then
  echo ""
  echo "Release steps:"
  echo "  1. git tag $TAG && git push origin $TAG"
  echo "  2. upload $ZIP to the $TAG GitHub Release as an asset"
  echo "  3. ensure catalog.json is committed on main (raw URL must be reachable)"
  echo ""
  echo "Or run:  ./scripts/pack.sh --release  (does all of the above automatically)"
  exit 0
fi

# --- --release path: tag + push + gh release create ---
if [[ $CATALOG_OK -eq 0 ]]; then
  echo "[ERR] catalog.json is out of sync — fix it before releasing." >&2
  echo "      Re-run without --release to see the fix values." >&2
  exit 2
fi

cd "$REPO_ROOT"

# Reject if working tree is dirty (tag would capture uncommitted state).
if [[ -n "$(git status --porcelain)" ]]; then
  echo "[ERR] working tree has uncommitted changes — commit first:" >&2 >&2
  git status --short >&2
  exit 3
fi

# Reject if tag already exists.
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "[ERR] tag $TAG already exists." >&2
  exit 4
fi

# Require gh CLI for release creation.
if ! command -v gh >/dev/null 2>&1; then
  echo "[ERR] gh CLI not found on PATH. Install it or run the manual steps:" >&2
  echo "      git tag $TAG && git push origin $TAG" >&2
  echo "      gh release create $TAG $ZIP --title $TAG --notes '...'" >&2
  exit 5
fi

echo "[release] creating tag $TAG and pushing..."
git tag "$TAG"
git push origin "$TAG"

echo "[release] creating GitHub Release and uploading $ZIP..."
gh release create "$TAG" "$ZIP" \
  --title "$TAG" \
  --notes "km-baseline preset $TAG

Install:
\`\`\`bash
specify preset add --from https://github.com/CherryYin/knowledge-speckit/releases/download/$TAG/km-baseline-$VERSION.zip --priority 5
\`\`\`

Or via catalog:
\`\`\`bash
specify preset catalog add https://raw.githubusercontent.com/CherryYin/knowledge-speckit/main/catalog.json
specify preset add km-baseline --priority 5
\`\`\`
"

echo ""
echo "[release] done."
echo "  Release: https://github.com/CherryYin/knowledge-speckit/releases/tag/$TAG"
echo "  Asset:   $ZIP"
