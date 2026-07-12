# Knowledge Management Analysis Guardrails

These guardrails layer **before** the core `speckit.analyze` flow. They add
knowledge-management-specific cross-artifact consistency checks on top of the
standard analysis passes.

## Before completing analysis for the active feature, you MUST:

1. Confirm there is an active feature directory for the requested work.
2. Read the active `spec.md`, `clarify.md`, `plan.md`, and `tasks.md`.
3. Run all standard analysis passes (duplication, ambiguity, underspecification,
   constitution alignment, coverage gaps, inconsistency).
4. Run the **KM-specific cross-artifact checks** (below).
5. Record the analysis result in a feature-scoped artifact named `analyze.md`
   beside the active `spec.md`.
6. Ensure `analyze.md` captures, at minimum:
   - the analyzed feature path
   - a summary of consistency findings (standard + KM-specific)
   - blocker-level issues
   - non-blocking follow-ups
   - the final verdict: ready to implement / not ready to implement
7. Refuse to declare analysis complete if blocker-level inconsistencies remain
   unresolved and not explicitly accepted.
8. Direct the workflow back to the appropriate earlier step when analysis
   discovers spec, clarification, planning, or tasking problems.

## KM-Specific Cross-Artifact Checks

In addition to standard consistency analysis, verify the following KM-specific
alignments across spec.md, plan.md, and tasks.md:

### Provenance Alignment
- Does the spec require provenance for new knowledge?
- Does the plan specify how provenance metadata is recorded?
- Do the tasks include provenance implementation tasks?
- **Blocker**: spec requires provenance but plan or tasks omit it.

### Schema & Migration Alignment
- Does the spec introduce new entities or fields?
- Does the plan include a migration strategy?
- Do the tasks include migration creation and verification tasks?
- **Blocker**: spec changes schema but plan or tasks omit migrations.

### Retrieval Alignment
- Does the spec specify a retrieval strategy for new content?
- Does the plan define index updates or embedding changes?
- Do the tasks include index/retrieval implementation tasks?
- **Blocker**: spec adds searchable content but plan or tasks omit retrieval work.

### Agent Safety Alignment
- Does the spec identify knowledge-modifying agent tools?
- Does the plan define confirmation gates for those tools?
- Do the tasks include agent safety implementation and test tasks?
- **Blocker**: spec exposes modifying agent tools but plan or tasks omit safety gates.

### Pipeline Coverage Alignment
- Does the spec describe a pipeline (ingestion → extraction → storage → retrieval)?
- Does the plan address every pipeline stage the spec mentions?
- Do the tasks cover implementation for every pipeline stage?
- **Blocker**: spec describes a pipeline stage that plan or tasks skip entirely.

### Test Strategy Alignment
- Does the spec define acceptance scenarios for knowledge quality?
- Does the plan define knowledge quality tests (parser accuracy, retrieval relevance)?
- Do the tasks include corresponding test tasks?
- **Blocker**: spec has quality acceptance criteria but plan or tasks omit quality tests.

## The analysis step MUST NOT:

- Claim analysis is complete without creating `analyze.md`.
- Proceed as if spec, plan, and tasks are aligned when KM-specific blocker-level
  conflicts remain.
- Hide contradictions between artifacts inside vague summary language.
- Treat a quick skim as equivalent to a real cross-artifact consistency review.
- Skip KM-specific checks when the feature touches knowledge pipeline, schema,
  retrieval, or agent tools.
