# Example Product Initialization Plan

## Metadata

- Project Slug: example-product
- Task Slug: example-product-initialization
- Created: 2026-06-08-10-20-00
- Owner Mode: architect
- Status: active
- Related State: `docs/agent/PROJECT_STATE.md`

## Objective

Initialize a clean repo-native agent operating layer for Example Product so
future agents can plan, implement, validate, and hand off larger multi-turn work
from a stable template baseline.

## Scope

- Keep the repository-level agent contract in `AGENTS.md`.
- Keep the current-state entry point in `docs/agent/PROJECT_STATE.md`.
- Keep reusable artifact templates in `docs/agent/templates/`.
- Keep the directory and naming contract in `docs/agent/DIRECTORY_STRUCTURE.md`.
- Keep mechanical validation in `scripts/agent-check.ps1`.
- Keep the lightweight repo-local skill in `.agents/skills/project-agent/`.

## Non-Scope

- No product feature implementation is defined yet.
- No architecture decision is required yet.
- No historical trial artifacts are part of this clean baseline.

## Current Context

This repository is initialized as a reusable example-product baseline. Future
agents should treat the files under `docs/agent/templates/` as copyable shapes
and create new timestamped artifacts only when a real non-trivial task begins.

## Architecture Decisions

- Use a repo-native agent operating layer rather than an external
  `workspace/project` wrapper.
- Keep the operating layer focused on larger, multi-turn, resumable, and
  auditable development work.
- Use `PROJECT_STATE.md` as the fixed resume entry point.

## State Or Data Model

No product state or data model has been defined yet. Future plans should add
state transitions, inputs, outputs, data ownership, and failure modes when a
real project feature requires them.

## Acceptance Scenarios

### Happy Path

- A future agent can read `AGENTS.md` and `docs/agent/PROJECT_STATE.md` and
  understand that this is a clean example-product baseline.
- A future agent can copy templates from `docs/agent/templates/` to create real
  task artifacts.

### Edge Cases

- If no real task is active, `PROJECT_STATE.md` should point to this
  initialization plan and mark downstream reports as missing or optional.

### Regression Cases

- `scripts/agent-check.ps1 -Strict` should pass for the clean baseline.
- `.agents/skills/project-agent` should pass skill validation.

### Ambiguous Cases

- Real product goals, commands, and repository-specific constraints are not yet
  known. Future agents should update `AGENTS.md` and `PROJECT_STATE.md` when
  those facts become available.

## Validation Strategy

- Run `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict`.
- Run `python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent`.
- Run `git status --short --branch`.

## Risks

- This baseline is intentionally generic, so future agents must not mistake
  example placeholders for real product requirements.
- Mechanical checks validate document structure and links, not semantic
  correctness.

## Implementation Notes

- Use `example-product` as the placeholder project slug.
- Use `Example Product` as the placeholder display name.
- Replace placeholder values when applying this baseline to a real repository.

## Next Owner

- developer
