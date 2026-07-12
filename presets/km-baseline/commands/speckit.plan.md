# Knowledge Management Planning Guardrails

These guardrails layer **before** the core `speckit.plan` flow. They add a
knowledge-management lens for implementation planning — checking schema, retrieval,
provenance, and agent safety implications that a generic plan might miss.

## Before producing or updating the implementation plan, you MUST:

1. Read `.specify/memory/constitution.md`.
2. Confirm there is an active feature spec for the requested work.
3. Confirm a feature-scoped `clarify.md` exists beside the active `spec.md`; if not,
   stop and direct the workflow to `/speckit.clarify` before planning.
4. Read the active `spec.md` and `clarify.md`.
5. Run a **constitution check** against all KM principles. Record status in the plan.
6. Identify **schema/migration impact**. If persisted data or schema changes, database
   migrations MUST be planned. Breaking changes MUST include a backward-compatibility
   assessment.
7. Identify **retrieval index impact**. If indexes or embedding models change, a reindex
   strategy MUST be planned. Retrieval changes MUST include test cases verifying search
   relevance does not degrade for existing content.
8. Identify **provenance impact**. If the feature creates or transforms knowledge, the
   plan MUST specify how provenance metadata (source type, source reference, creation
   timestamp, origin agent/user) is recorded.
9. Identify **agent tool safety implications**. If tools modify knowledge, confirmation
   gates MUST be planned. Agent-generated knowledge MUST be clearly marked in provenance.
10. Check whether existing parsers, extractors, services, models, or patterns should be
    reused before creating new ones.
11. Define the test strategy: `unit`, `functional`, and **knowledge quality tests**
    (parser accuracy, retrieval relevance, agent tool safety).

## The plan MUST NOT:

- Introduce unrelated architecture changes.
- Produce a plan for work that does not have an active spec.
- Skip the clarify step — if `clarify.md` is missing, stop.
- Introduce new services, parsers, or entities without explaining why reuse is
  insufficient.
- Leave changed behavior without defined automated test coverage.
- Skip test strategy for knowledge pipeline changes.
- Create knowledge storage without provenance metadata.
- Allow agent tools to modify knowledge without confirmation gates.
- Weaken provenance, security, or agent safety requirements without explicit approval.

If the spec conflicts with the constitution, stop and report the conflict before
planning.
