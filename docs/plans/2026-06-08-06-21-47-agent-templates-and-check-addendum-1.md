# Agent Templates And Check Plan Addendum 1

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: agent-templates-and-check
- Created: 2026-06-08-06-21-47
- Addendum Number: 1
- Base Plan: `docs/plans/2026-06-08-05-26-41-agent-templates-and-check.md`
- Owner Mode: architect
- Status: active

## Reason For Addendum

Review feedback identified two template-contract improvements and one future
enhancement:

- `AGENTS_TEMPLATE.md` duplicated too much of `AGENTS.md` and
  `DIRECTORY_STRUCTURE.md`.
- Template metadata used `Task Slug` without clearly distinguishing it from
  `Project Slug`.
- Client-facing Chinese output should be tracked as a separate future export
  layer instead of mixing languages into source artifacts.

## Plan Changes

- Reduce `AGENTS_TEMPLATE.md` to a copyable project-specific skeleton and point
  detailed artifact rules at `docs/agent/DIRECTORY_STRUCTURE.md`.
- Add naming terminology to `docs/agent/DIRECTORY_STRUCTURE.md`, clarifying
  `Project Slug`, `Task Slug`, `Artifact Type`, timestamp, and owner mode.
- Add `Project Slug` to task artifact template metadata so the two slug levels
  are visible wherever reports are created.
- Add the Chinese output/export layer to the project todo list, without
  implementing translation in this task.

## Updated Acceptance Scenarios

### Added

- `AGENTS_TEMPLATE.md` is concise and avoids restating directory details owned
  by `DIRECTORY_STRUCTURE.md`.
- Task templates preserve `Task Slug` but also show `Project Slug`.
- `DIRECTORY_STRUCTURE.md` defines the naming terms used by templates.
- `PROJECT_STATE.md` records the future Chinese export layer as planned work.

### Changed

- Template completeness now means "complete enough to copy" rather than
  "repeat every contract detail in every template."

### Removed

- None.

## Updated Validation Strategy

- Run `scripts/agent-check.ps1` from the repository root.
- Run `scripts/agent-check.ps1 -Strict`.
- Inspect template metadata with `rg "Project Slug|Task Slug"`.

## Risks And Mitigations

- Risk: over-pruning `AGENTS_TEMPLATE.md` could make bootstrapping unclear.
  Mitigation: keep required first reads, project-specific commands, and update
  permissions in the template while linking to the authoritative directory
  contract.

## Next Owner

- developer
