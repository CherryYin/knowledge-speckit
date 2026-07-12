# Knowledge Management Tasks Guardrails

These guardrails layer **before** the core `speckit.tasks` flow. They help ensure the
task list reflects the real work typically needed in a knowledge management codebase —
not just the happy-path code edit, but the pipeline, schema, retrieval, and agent
work that surrounds it.

## Task review focus

When generating or reviewing tasks, check whether the task breakdown includes the
relevant KM work items. Include tasks only when the change actually touches those
concerns:

### Schema & Migration
- Database migration tasks when persisted data or schema changes.
- Backward-compatibility verification tasks when breaking changes.
- Index creation or rebuild tasks when retrieval indexes change.

### Knowledge Pipeline
- Parser/extractor implementation tasks placed in the correct module.
- Provenance tracking tasks when new knowledge sources are introduced.
- Transformation tasks for derived knowledge (summaries, embeddings, entities).

### Retrieval
- Search query builder / retrieval service tasks.
- Vector index / embedding pipeline update tasks.
- Relevance scoring / ranking tasks.

### Agent Integration
- Agent tool implementation tasks.
- Safety boundary / confirmation gate tasks.
- Agent tool error handling tasks.

### Testing
- Unit tests for parsers, extractors, services.
- Functional tests for end-to-end knowledge flows.
- Knowledge quality tests (parser accuracy, retrieval relevance).
- Agent tool safety tests.

### Validation
- Lint, typecheck, and test suite tasks after implementation.

## You MUST NOT:

- Turn every reminder into a mandatory task — include only what's relevant.
- Force migration/dependency tasks when the change doesn't touch those concerns.
- Replace concrete tasks with vague placeholders.
- Omit test tasks for behavior changes.
- Omit provenance tasks when the feature creates or transforms knowledge.
