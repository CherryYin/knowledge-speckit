# Knowledge Management Implementation Guardrails

These guardrails layer **before** the core `speckit.implement` flow. They enforce
knowledge-management-specific invariants during implementation that a generic
implementer might overlook.

## When implementing tasks, you MUST:

1. Read `.specify/memory/constitution.md` before starting.
2. Confirm the active feature has `spec.md`, `plan.md`, and `tasks.md`.
3. Follow the task plan phase by phase. Do not skip phases.
4. Respect dependencies: sequential `[S]` tasks in order, parallel `[P]` tasks
   can run together.
5. Run knowledge pipeline operations through the proper storage and indexing
   pipeline — **never bypass provenance recording or schema validation**.
6. For all new knowledge records, ensure provenance metadata is written: source type,
   source reference, creation timestamp, and origin (user or agent).
7. For derived/transformed knowledge (summaries, embeddings, extracted entities),
   record the derivation chain so the artifact is traceable to its source material.
8. For agent tools: implement safety boundaries and confirmation gates as specified
   in the plan. Agent-generated knowledge MUST be marked as agent-originated in
   provenance metadata.
9. Use database migrations for all schema changes — never ad-hoc schema mutations.
10. Mark completed tasks as `[X]` in `tasks.md` immediately after completion.
11. Run validation (lint, typecheck, tests) after each phase, not just at the end.
12. Verify each user story independently at validation checkpoints.

## You MUST NOT:

- Implement features that don't have an active spec.
- Skip the plan or tasks phase.
- Create knowledge records without provenance metadata.
- Bypass database migrations — always migrate, never ad-hoc schema changes.
- Leave agent tools without safety boundaries if they modify knowledge.
- Bundle unrelated refactors into feature work.
- Mark a knowledge-modifying agent tool as complete without a safety test.
