# Knowledge Management Baseline Preset

A spec-kit preset that adds knowledge-management-specific guardrails to the standard
spec-driven development workflow. It layers **before** the core spec-kit commands using
the `prepend` composition strategy — the core workflow (specify → clarify → plan →
tasks → implement) stays intact, with KM-specific checks injected at each stage.

## What It Adds

| Command | Guardrail Focus |
|---------|----------------|
| `speckit.specify` | Knowledge domain identification, pipeline risk scan, provenance |
| `speckit.clarify` | KM ambiguity taxonomy (scope, pipeline, schema, retrieval, agent) |
| `speckit.plan` | Schema/migration, retrieval index, agent safety, reuse assessment |
| `speckit.tasks` | Pipeline, schema, retrieval, agent, and test task coverage |
| `speckit.implement` | Provenance enforcement, migration enforcement, agent safety |
| `speckit.constitution` | 8 KM principles: knowledge-first, provenance, schema, retrieval, reuse, testing, increments, agent-safe |

## Installation

Install into any spec-kit project. Pick one of the three methods below.

### From a release ZIP (recommended for cross-repo use)

```bash
specify preset add --from https://github.com/CherryYin/knowledge-speckit/releases/download/v1.1.0/km-baseline-1.1.0.zip --priority 5
```

One command, no Python environment required. Works in any repo that already has
`specify` on PATH. Pin the version via the URL tag (`v1.1.0`); bump it on upgrade.

### From a catalog (enables short `add km-baseline`)

Register this repo's catalog once per machine, then install by preset id:

```bash
# register the catalog (user-level, applies to all projects)
specify preset catalog add https://raw.githubusercontent.com/CherryYin/knowledge-speckit/main/catalog.json

# install by short id
specify preset add km-baseline --priority 5
```

`specify preset search km` and `specify preset info km-baseline` now resolve from
the catalog. To upgrade, republish `catalog.json` with the new `version` /
`download_url` and re-run `add`.

### From a local clone (development)

```bash
specify preset add --dev ./presets/km-baseline --priority 5
```

## Verification

```bash
specify preset resolve speckit.specify
specify preset list
```
