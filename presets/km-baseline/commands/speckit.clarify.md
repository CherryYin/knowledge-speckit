# Knowledge Management Clarification Guardrails

These guardrails layer **before** the core `speckit.clarify` flow. They ensure
clarification questions target knowledge-management-specific ambiguity that would
materially affect pipeline design, schema, retrieval, or agent safety.

## Before completing clarification, you MUST:

1. Read `.specify/memory/constitution.md`.
2. Confirm there is an active feature spec (check `.specify/feature.json`).
3. Read the active `spec.md` completely.
4. Run the **KM ambiguity taxonomy scan** (below) and mark each category
   Clear / Partial / Missing.
5. Ask up to 5 targeted questions to resolve or explicitly defer blocker-level
   ambiguities, prioritized by the taxonomy below.
6. Record the outcome in `clarify.md` beside the active `spec.md`.
7. Mirror clarified decisions back into `spec.md` when answers materially change
   requirements, scope, acceptance criteria, or constraints.

## KM Ambiguity Taxonomy

Scan the spec and mark each category Clear / Partial / Missing:

### Knowledge Scope
- Which knowledge domain(s) are affected?
- What content types are involved? (files, URLs, RSS, repos, papers, notes...)
- What is the expected volume and velocity of knowledge ingest/lookup?

### Pipeline & Parsing
- What formats need parsing? Is parsing accuracy specified?
- Are there format-specific edge cases? (encrypted PDFs, malformed HTML, large files...)
- Does extraction produce new entity types or relationships?

### Schema & Storage
- What data models change? Are migrations needed?
- Are there backward-compatibility concerns?
- What provenance metadata must be recorded?

### Retrieval
- What retrieval strategy is expected? (SQL, vector, hybrid, full-text)
- Are there relevance/quality expectations?
- Do indexes or embedding models change?

### Agent Integration
- What agent tools are exposed or changed?
- What safety boundaries apply? (read-only vs. modifying)
- Are confirmation gates needed for knowledge-modifying tools?

### Provenance & Traceability
- Can every piece of new knowledge be traced to its origin?
- Is the derivation chain recorded for transformed knowledge?

## You MUST NOT:

- Claim clarification is complete without creating `clarify.md`.
- Leave blocker-level ambiguity undocumented.
- Invent answers the user did not confirm.
- Ask more than 5 questions — prioritize by impact on architecture, pipeline,
  schema, retrieval, or agent safety.
