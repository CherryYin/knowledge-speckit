<!--
Sync Impact Report
- Version change: 0.1.0 -> 1.0.0
- Modified principles: none (initial KM constitution from template)
- Added sections: Core Principles (8), Governance
- Removed sections: none
- Templates requiring updates:
  - ✅ `.specify/templates/spec-template.md` (reviewed; no changes required)
  - ✅ `.specify/templates/plan-template.md` (reviewed; no changes required)
  - ✅ `.specify/templates/tasks-template.md` (reviewed; no changes required)
  - ✅ `.specify/templates/checklist-template.md` (reviewed; no changes required)
- Follow-up TODOs:
  - Quality commands: DEFERRED: exact repo commands not confirmed / owner: user / when: before merge-gated CI is enabled
  - Release, rollback, and observability expectations: DEFERRED: not defined yet / owner: user / when: before first production release
-->
# Knowledge Management Constitution

## Core Principles

### 1. Knowledge-First Delivery
Every meaningful change MUST start from a written spec that states the knowledge
value, acceptance criteria, constraints, non-goals, and known risks before
implementation begins.

The spec MUST identify which knowledge domain the change affects: sources, notes,
memory, wiki, assets, agents, retrieval, ingestion, or infrastructure.

When the spec describes a knowledge pipeline (ingestion → extraction → storage →
retrieval), it MUST include a Mermaid flow diagram so reviewers can trace how raw
content becomes searchable knowledge.

Within this repository, any feature request, behavior change, bug fix, refactor with
behavioral risk, or integration change MUST enter the workflow through
`/speckit.specify` before planning, tasking, or coding. AI agents MUST NOT jump
directly to implementation without an active spec.

Low-risk, narrowly scoped changes MAY use a lightweight spec, but they still MUST go
through `/speckit.specify` and leave a written, traceable record of intent, scope,
acceptance check, and explicit non-goals.

### 2. Provenance & Traceability
Every piece of knowledge stored in the system — sources, notes, memory nodes, wiki
pages, extracted entities — MUST be traceable to its origin: a user action, an
imported file, a web URL, an RSS feed, or an agent-generated artifact.

Implementation MUST NOT create knowledge records without recording provenance
metadata (source type, source reference, creation timestamp, creation agent or user).

When knowledge is derived or transformed (summaries, embeddings, extracted entities),
the derivation chain MUST be recorded so users can trace any knowledge artifact back
to its original source material.

### 3. Schema Discipline
All knowledge data models MUST be explicit, documented, and versioned. Schema changes
MUST go through database migrations — never ad-hoc schema mutations.

New entities, fields, or relationships MUST be justified against existing models. If
an existing model can be extended without breaking compatibility, prefer extension
over creation.

Breaking schema changes (renamed columns, removed fields, changed types) MUST include
a migration plan and a backward-compatibility assessment in the plan.

### 4. Retrieval Quality
Knowledge that cannot be found is knowledge that does not exist. Every feature that
adds or transforms knowledge MUST consider how that knowledge will be retrieved.

If the feature adds new content types, the plan MUST specify the retrieval strategy:
SQL filtering, vector similarity search, full-text search, or hybrid. If vector
embeddings are involved, the plan MUST specify the embedding model and index update
strategy.

Retrieval changes (new index fields, changed embedding models, modified search logic)
MUST include test cases that verify search relevance does not degrade for existing
content.

### 5. Reuse Before Reinvention
Reuse existing parsers, extractors, services, models, and patterns before creating
new ones. New abstractions MUST be justified — explain why existing components are
insufficient.

Before introducing a new parser for a document format, check whether an existing
parser can be extended. Before creating a new service, check whether an existing
service can absorb the responsibility.

New API endpoints MUST NOT duplicate existing endpoint capabilities. New agent tools
MUST NOT duplicate existing tool functionality.

### 6. Testable Knowledge Pipelines
Behavior changes MUST define required verification before implementation. Default
required layers are `unit` and `functional`.

Knowledge pipeline changes (parsing, extraction, retrieval) MUST include quality
tests:
- Parser tests with representative sample documents
- Extraction accuracy tests with known expected output
- Retrieval relevance tests with known queries and expected results

Agent tool changes MUST include safety tests that verify permission boundaries and
confirmation gates work correctly.

Bug fixes SHOULD include a regression test.

### 7. Small, Reviewable Increments
Implementation SHOULD be split into small tasks. Each user story in the spec SHOULD
be independently completable and testable.

Unrelated refactors, dependency upgrades, formatting churn, and architecture changes
MUST NOT be bundled into feature work unless the plan explicitly includes them.

Prefer incremental delivery: complete the foundational layer, then add user stories
one at a time, validating each independently before moving to the next.

### 8. Agent-Safe Knowledge Access
Agent tools that read knowledge MUST respect the same permission boundaries as
user-facing APIs. Agent tools that modify knowledge (create, update, delete) MUST
require explicit user confirmation unless operating in an explicitly user-initiated
batch context.

Agent-generated knowledge MUST be clearly marked as agent-originated in provenance
metadata, distinguishable from user-created knowledge.

Agent tools MUST NOT bypass provenance recording, schema validation, or retrieval
indexing. Any knowledge written by an agent MUST go through the same storage and
indexing pipeline as user-written knowledge.

## Governance

This constitution supersedes all other practices within this repository. Amendments
require documentation, a version bump, and a recorded rationale.

All specs, plans, and code reviews MUST verify compliance with these principles.
Conflicts between a spec and the constitution MUST be resolved before planning
proceeds.

**Version**: 1.0.0 | **Ratified**: 2026-07-11 | **Last Amended**: 2026-07-11
