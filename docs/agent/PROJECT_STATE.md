# Project State

This file is the fixed entry point for humans and Codex to resume work. Keep it
short, current, and linked to the durable artifacts that contain detail.

## Identity

- Project Name: Example Product
- Project Slug: example-product
- Project Aliases: example_product, example-app
- Repository: TBD

## Current Status

- Current Objective: Initialize the repo-native agent operating layer for
  Example Product.
- Current Phase: planning
- Current Owner Mode: architect
- Last Updated: 2026-06-08-10-24-42

Allowed phases:

- planning
- implementation
- qa
- review
- delivery
- blocked
- shipped

## Latest Artifacts

| Artifact | Path | Status | Notes |
| --- | --- | --- | --- |
| Directory Contract | `docs/agent/DIRECTORY_STRUCTURE.md` | active | Defines the repo-native agent tree. |
| Latest Plan | `docs/plans/2026-06-08-10-20-00-example-product-initialization.md` | active | Initialization plan for the clean example product baseline. |
| Latest Addendum | `TBD` | not-needed | Use when implementation changes a plan. |
| Latest Decision | `TBD` | not-needed | Use ADRs for architecture or product direction changes. |
| Latest Dev Report | `TBD` | missing | Create after non-trivial implementation. |
| Latest QA Report | `TBD` | missing | Create after validation of non-trivial work. |
| Latest Review Report | `TBD` | optional | Use for independent review or high-risk diffs. |
| Latest Delivery Report | `TBD` | optional | Use before shipping or handing off completed work. |
| Latest Handoff | `TBD` | missing | Create before pausing or switching threads. |

## Open Risks

- Example placeholders must be replaced with real project facts before this
  baseline is used for production work.
- `scripts/agent-check.ps1` validates artifact structure and links, not deep
  semantic correctness.

## Blockers

- None.

## Next Recommended Action

1. Replace example project identity with real project identity when applying
   this baseline.
2. Create new timestamped artifacts when a real non-trivial task begins.

## Last Verified Commands

| Command | Result | Notes |
| --- | --- | --- |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Clean example-product baseline passed with 44 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Clean example-product baseline strict check passed with 44 checks and 0 warnings. |
| `python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Skill validator reported "Skill is valid!". |

## Recently Changed Files

- `AGENTS.md`
- `docs/agent/PROJECT_STATE.md`
- `docs/agent/DIRECTORY_STRUCTURE.md`
- `docs/agent/PROMPT_USAGE.md`
- `docs/agent/templates/`
- `.agents/skills/project-agent/`
- `scripts/agent-check.ps1`
- `docs/plans/2026-06-08-10-20-00-example-product-initialization.md`

## Update Rules

Update this file whenever:

- the current objective changes;
- the phase changes;
- a latest artifact path changes;
- risks or blockers change;
- validation commands are run;
- the next recommended action changes;
- a handoff is needed.

Keep detailed reasoning in the linked artifacts. Keep this file as a compact
navigation index.
