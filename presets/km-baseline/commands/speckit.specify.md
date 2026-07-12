# Knowledge Management Specify Guardrails

These guardrails layer **before** the core `speckit.specify` flow. They enforce
knowledge-management-specific spec-entry requirements before feature specification
work begins.

## Before creating or updating `spec.md`, you MUST:

1. Identify which **knowledge domain** the feature touches and record it explicitly
   in the spec. Valid domains: `sources`, `notes`, `memory`, `wiki`, `assets`,
   `agents`, `retrieval`, `ingestion`, `infrastructure`. A feature may touch multiple
   domains — list all that apply.
2. Run the **knowledge pipeline risk scan** (below) and surface every trigger as an
   explicit note, risk, or open question in the spec.
3. Assess whether the requested spec is too broad for a single implementation track.
   If the work can be cleanly split by knowledge domain, pipeline stage, or user
   story, recommend splitting it into multiple specs before continuing.
4. Prefer smaller specs when that leads to clearer scope, easier review, and more
   predictable delivery.
5. When the spec describes a knowledge pipeline (ingestion → extraction → storage →
   retrieval), include a Mermaid flow diagram so reviewers can trace how raw content
   becomes searchable knowledge.

## Knowledge Pipeline Risk Scan

For each business requirement, check whether it implicitly depends on capabilities
that may not already exist in the current system. Surface an explicit note, risk, or
open question when the requirement appears to depend on any of the following:

### 1. Parsing & Ingestion

- The requirement assumes support for a document format not yet handled (PDF, DOCX,
  HTML, RSS, arXiv, GitHub repos, images, audio/video...).
- The requirement assumes parsing accuracy or speed beyond current capability.
- The requirement involves large-file or batch ingestion that may strain the pipeline.
- The requirement imports external content without defining provenance metadata.

### 2. Extraction & Knowledge Modeling

- The requirement assumes entity/relationship extraction that is not yet implemented.
- The requirement introduces new entity types or relationships not in the current schema.
- The requirement requires a knowledge graph model change or new memory node types.

### 3. Retrieval

- The requirement assumes vector search, hybrid search, or full-text search that may
  not be indexed for the new content type.
- The requirement changes the embedding model or index structure.
- The requirement demands retrieval quality (precision/recall) beyond current capability.

### 4. Agent Integration

- The requirement exposes new agent tools.
- The requirement allows agents to modify knowledge — if so, confirmation gates MUST
  be defined in the spec.
- The requirement assumes agent capabilities (tool use, memory, multi-step reasoning)
  not yet confirmed in the project.

### 5. Provenance & Traceability

- The requirement creates knowledge without a clear source.
- The requirement transforms or derives knowledge (summaries, embeddings, extracted
  entities) without a derivation chain.
- The requirement imports external content without recording source type, source
  reference, and creation metadata.

## You MUST NOT:

- Create `spec.md` without identifying the knowledge domain(s).
- Hide pipeline risks behind vague requirements.
- Keep a single oversized spec when the work is more understandable as multiple
  smaller specs.
- Jump to implementation details (tech stack, APIs, code structure) in the spec —
  the spec describes WHAT and WHY, not HOW.
- Omit provenance requirements when the feature creates or transforms knowledge.

## Recording format

Use a clearly labeled field near the top of `spec.md`:

```md
- Knowledge Domain: sources, retrieval
```
