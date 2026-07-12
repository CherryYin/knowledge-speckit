# Knowledge Management Checklist Guardrails

These guardrails layer **before** the core `speckit.checklist` flow. They ensure
generated checklists validate knowledge-management-specific requirement quality —
not just generic spec completeness.

## Checklist Purpose for Knowledge Management

Checklists are **unit tests for KM requirements writing**. They validate whether
the spec's requirements are complete, unambiguous, and ready for implementation
in a knowledge pipeline context.

**NOT for verification/testing**:

- ❌ NOT "Verify the parser returns correct output" (implementation test)
- ❌ NOT "Confirm search returns results" (functional test)

**FOR KM requirements quality validation**:

- ✅ "Are all document formats that need parsing explicitly listed in the spec?" (completeness)
- ✅ "Is provenance metadata defined for every new knowledge source?" (completeness)
- ✅ "Does the spec define what happens when parsing fails on a corrupted file?" (edge cases)
- ✅ "Are retrieval strategy expectations quantified (precision/recall targets)?" (clarity)
- ✅ "Does the spec define confirmation gates for all knowledge-modifying agent tools?" (coverage)

## When generating a checklist, you MUST:

1. Read `.specify/memory/constitution.md` and check the spec against all 8 KM principles.
2. Include checklist categories relevant to the feature's knowledge domain(s).
3. Generate items that test whether the **requirements** are well-written — not whether
   the implementation works.
4. Ensure every KM requirement type present in the spec has a corresponding checklist item:

### Knowledge Pipeline Checklist Items (if feature touches ingestion/extraction)
- Are all input formats explicitly listed?
- Is parsing accuracy or quality threshold specified?
- Are edge cases for malformed/corrupted/large inputs defined?
- Is provenance metadata required for all extracted knowledge?
- Is the derivation chain specified for transformed knowledge?

### Schema & Storage Checklist Items (if feature touches data models)
- Are all new/changed entities documented with fields and relationships?
- Are migration requirements stated?
- Are backward-compatibility concerns addressed?
- Are index requirements specified?

### Retrieval Checklist Items (if feature touches search)
- Is the retrieval strategy specified (SQL/vector/hybrid/full-text)?
- Are relevance or quality expectations quantified?
- Are index update requirements defined?
- Is reindex strategy specified for existing content?

### Agent Integration Checklist Items (if feature touches agent tools)
- Are all agent tools that modify knowledge identified?
- Are confirmation gates defined for each modifying tool?
- Is agent-originated provenance marking required?
- Are error handling and fallback behaviors specified?

### Provenance Checklist Items (if feature creates or transforms knowledge)
- Is source type defined for all new knowledge?
- Is source reference (URL, file path, feed ID) required?
- Is creation timestamp and origin (user/agent) required?
- Is the derivation chain specified for derived knowledge?

## You MUST NOT:

- Generate implementation-verification items (those belong in tasks.md tests, not checklists).
- Include checklist categories for domains the feature doesn't touch.
- Leave KM-specific requirements unchecked — every KM requirement type in the spec needs at least one checklist item.
- Use vague items like "Check retrieval works" — be specific about what requirement quality is being validated.
