# Knowledge Management Constitution Guardrails

These guardrails layer **before** the core `speckit.constitution` flow. They guide
the creation and amendment of a constitution tailored to a knowledge management
system.

## When creating or updating the constitution, ensure these KM principles are present:

### 1. Knowledge-First Delivery
Every meaningful change MUST start from a written spec that identifies the knowledge
domain affected and states user value, acceptance criteria, constraints, non-goals,
and known risks.

### 2. Provenance & Traceability
Every piece of knowledge — sources, notes, memory nodes, wiki pages, extracted
entities — MUST be traceable to its origin. Derived knowledge MUST record its
derivation chain.

### 3. Schema Discipline
All knowledge data models MUST be explicit, documented, and versioned. Schema changes
MUST go through migrations. Breaking changes MUST include a backward-compatibility
assessment.

### 4. Retrieval Quality
Knowledge that cannot be found is knowledge that does not exist. Features that add or
transform knowledge MUST consider retrieval strategy. Retrieval changes MUST include
tests verifying relevance does not degrade.

### 5. Reuse Before Reinvention
Reuse existing parsers, extractors, services, and models before creating new ones.
New abstractions MUST be justified.

### 6. Testable Knowledge Pipelines
Pipeline changes MUST include quality tests: parser accuracy, extraction correctness,
retrieval relevance, and agent tool safety.

### 7. Small, Reviewable Increments
Each user story should be independently completable and testable.

### 8. Agent-Safe Knowledge Access
Agent tools that modify knowledge MUST require explicit user confirmation.
Agent-generated knowledge MUST be clearly marked in provenance metadata.

## You MUST NOT:

- Remove or weaken any of the 8 KM principles without explicit team approval.
- Create a constitution that omits provenance, retrieval quality, or agent safety.
- Leave principles vague — use MUST/SHOULD, not "should" or "could".
