# knowledge-speckit

A [spec-kit](https://github.com/github/spec-kit) preset that adds knowledge-management
guardrails to spec-driven development — sources, notes, memory, wiki, retrieval, and
agent workflows.

## Preset

`km-baseline` — 8 KM guardrail commands layered before the core speckit workflow
(specify → clarify → plan → tasks → implement) via the `prepend` strategy.

| Command | Guardrail Focus |
|---------|----------------|
| `speckit.specify` | Knowledge domain, pipeline risk scan, provenance |
| `speckit.clarify` | KM ambiguity taxonomy |
| `speckit.plan` | Schema/migration, retrieval index, agent safety |
| `speckit.tasks` | Pipeline, schema, retrieval, agent task coverage |
| `speckit.implement` | Provenance enforcement, migration enforcement |
| `speckit.constitution` | 8 KM principles |
| `speckit.checklist` | KM requirement quality validation |
| `speckit.analyze` | Cross-artifact provenance/schema/retrieval alignment |

## Install

### From a release ZIP (recommended)

```bash
specify preset add --from https://github.com/CherryYin/knowledge-speckit/releases/download/v1.1.0/km-baseline-1.1.0.zip --priority 5
```

### Via catalog (enables short `add km-baseline`)

```bash
specify preset catalog add https://raw.githubusercontent.com/CherryYin/knowledge-speckit/main/catalog.json
specify preset add km-baseline --priority 5
```

### From a local clone (development)

```bash
specify preset add --dev ./presets/km-baseline --priority 5
```

## Verify

```bash
specify preset resolve speckit.specify
specify preset list
```

## Release a new version

```bash
# 1. bump version in presets/km-baseline/preset.yml AND catalog.json
# 2. commit
git add -A && git commit -m "release v<x.y.z>"
# 3. pack, tag, push, create GitHub Release with ZIP asset
./scripts/pack.sh --release
```

`scripts/pack.sh` verifies `catalog.json` stays in sync with `preset.yml` and
rejects dirty trees / duplicate tags before publishing.

## License

MIT
