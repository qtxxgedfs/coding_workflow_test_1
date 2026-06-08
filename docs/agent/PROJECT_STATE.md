# Project State

This file is the fixed entry point for humans and Codex to resume work. Keep it
short, current, and linked to the durable artifacts that contain detail.

## Identity

- Project Name: Coding Workflow Test 1
- Project Slug: coding-workflow-test-1
- Project Aliases: coding_workflow_test_1, new_1
- Repository: https://github.com/qtxxgedfs/coding_workflow_test_1

## Current Status

- Current Objective: Complete item 10, a real small-project trial of the
  repo-native agent operating layer.
- Current Phase: shipped
- Current Owner Mode: delivery
- Last Updated: 2026-06-08-09-55-00

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
| Latest Plan | `docs/plans/2026-06-08-09-20-52-small-project-trial.md` | active | Plan for item 10 small-project trial in `new_1_test_1`. |
| Latest Addendum | `TBD` | not-needed | No addendum is needed for the skill implementation yet. |
| Latest Decision | `TBD` | not-needed | Use ADRs for architecture or product direction changes. |
| Latest Dev Report | `docs/reports/dev/2026-06-08-09-45-00-small-project-trial.md` | active | Implementation evidence for item 10 trial. |
| Latest QA Report | `docs/reports/qa/2026-06-08-09-45-00-small-project-trial.md` | active | QA evidence for item 10 trial. |
| Latest Review Report | `docs/reports/review/2026-06-08-09-45-00-small-project-trial.md` | active | Review notes and friction assessment. |
| Latest Delivery Report | `docs/reports/delivery/2026-06-08-09-45-00-small-project-trial.md` | active | Delivery readiness for item 10. |
| Latest Handoff | `docs/handoffs/2026-06-08-09-45-00-small-project-trial.md` | active | Resume instructions for item 10. |

## Open Risks

- `scripts/agent-check.ps1` uses simple heading and state-link checks rather
  than deep semantic Markdown validation.
- The small project has focused browser smoke coverage, but no full
  accessibility, multi-browser, or visual regression suite.
- Full artifact chains are useful for supervised handoff but heavy for tiny
  static apps; keep a smaller preset available.
- Child-thread long turns make mid-course intervention harder; this is a real
  supervision friction.

## Blockers

- None.

## Next Recommended Action

1. Inspect the item 10 trial reports.
2. Decide whether to add a tiny-task preset to the lightweight skill.

## Last Verified Commands

| Command | Result | Notes |
| --- | --- | --- |
| `$null = [scriptblock]::Create((Get-Content -Raw -LiteralPath 'scripts\agent-check.ps1')); 'parse ok'` | passed | Confirmed `scripts/agent-check.ps1` parses after string fixes. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | expected-fail | Correctly failed before dev/QA report artifacts existed. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Root run passed with 56 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File new_1\scripts\agent-check.ps1 -Root D:\codex\coding_workflow_test_1\new_1` | passed | Parent-directory run passed with 56 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Template cleanup run passed with 71 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Template cleanup strict run passed with 71 checks and 0 warnings. |
| `rg "Project Slug\|Task Slug\|Naming Terms\|Chinese\|zh-CN\|agent-translate" docs/agent docs/plans docs/reports` | passed | Confirmed naming terms, slug metadata, and planned Chinese output entries. |
| `git ls-remote https://github.com/qtxxgedfs/coding_workflow_test_1.git` | passed | Remote repository is reachable and appears empty. |
| `git init -b main` | passed | Initialized local repository in `new_1`. |
| `git remote add origin https://github.com/qtxxgedfs/coding_workflow_test_1.git` | passed | Connected local repository to GitHub origin. |
| `rg --pcre2 "YYYY-MM-DD(?!-HH-MM-SS)\|Work Modes\|Agent Artifact Paths" .` | passed | No old naming patterns or removed section names remain. |
| `rg "YYYY-MM-DD-HH-MM-SS\|ADR-NNN\|Operating Posture\|Agent Documents" AGENTS.md docs/agent/DIRECTORY_STRUCTURE.md docs/agent/PROJECT_STATE.md` | passed | Confirmed new naming and concise section names are present. |
| `python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | blocked | Default Python lacked the `yaml` module required by `quick_validate.py`. |
| `$Target = Join-Path $env:TEMP 'codex-pyyaml-validate'; if (-not (Test-Path -LiteralPath $Target)) { python -m pip install --quiet --target $Target PyYAML }; $env:PYTHONPATH = $Target; python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Installed `PyYAML` in a temp validation directory and confirmed "Skill is valid!". |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Project-agent skill run passed with 86 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Project-agent skill strict run passed with 86 checks and 0 warnings. |
| `git status --short` | passed | Showed only intended uncommitted project-agent skill and artifact changes. |
| `git commit -m "Add project-agent skill"` | passed | Created the local project-agent skill commit; this state update was amended into the same commit. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | failed then passed | Initial overall audit failed on clean Git status; after the array fix, passed with 103 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | failed then passed | Initial strict audit failed on clean Git status; after the array fix, passed with 103 checks and 0 warnings. |
| `$Target = Join-Path $env:TEMP 'codex-pyyaml-validate'; $env:PYTHONPATH = $Target; python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Skill validator reported "Skill is valid!" during the 1-9 audit. |
| `git commit -m "Fix agent-check clean status handling"` | passed | Committed the clean Git status fix and related artifacts. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Post-commit clean-working-tree run passed with 102 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Post-commit clean-working-tree strict run passed with 102 checks and 0 warnings. |
| `git push origin main` | passed | Pushed local commits through `97da8cd` to `origin/main`. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Prompt usage run passed with 118 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Prompt usage strict run passed with 118 checks and 0 warnings. |
| `$Target = Join-Path $env:TEMP 'codex-pyyaml-validate'; $env:PYTHONPATH = $Target; python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Skill validator reported "Skill is valid!" after prompt usage documentation. |
| `fresh thread 019ea741-f032-7f40-ab7c-cf0ede205c23` | passed | Separate thread found `$project-agent`, read repo docs, reconstructed current project state, and did not modify files. |
| `fresh thread 019ea763-cd61-7941-a71c-64c01593e59a` | mixed-pass | Separate thread read the agent layer, wrote the item 10 plan, and created the small-project skeleton; it slowed before product implementation landed. |
| `node --check app.js` in sibling small project | passed | Small project JavaScript syntax valid. |
| `node tests\app.test.mjs` in sibling small project | passed | Small project behavior tests passed. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` in sibling small project | passed | Small project check passed with 25 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` in sibling small project | passed | Small project strict check passed with 40 checks and 0 warnings. |
| `node <temporary static server smoke script>` in sibling small project | passed | Static files served and expected content was present. |
| `playwright browser smoke script` | blocked | Runtime had `playwright` but was missing `playwright-core`. |
| `Codex in-app Browser smoke via http://127.0.0.1:4173/` in sibling small project | passed | Initial 4 cards, after add 5, filtered 2, reload preserved created item. |
| `git commit -m "Build decision triage board trial"` in sibling small project | passed | Created small project commit `3a77779`. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` | passed | Main repo check passed with 148 checks and 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` | passed | Main repo strict check passed with 148 checks and 0 warnings. |
| `$Target = Join-Path $env:TEMP 'codex-pyyaml-validate'; $env:PYTHONPATH = $Target; python C:\Users\wangx\.codex\skills\.system\skill-creator\scripts\quick_validate.py .agents\skills\project-agent` | passed | Skill validator reported "Skill is valid!". |
| `git commit -m "Run small project agent trial"` | passed | Main repository item 10 artifacts committed locally; branch is ahead of origin until pushed. |

## Recently Changed Files

- `.agents/skills/project-agent/SKILL.md`
- `.agents/skills/project-agent/agents/openai.yaml`
- `AGENTS.md`
- `docs/agent/PROJECT_STATE.md`
- `docs/agent/DIRECTORY_STRUCTURE.md`
- `docs/agent/templates/*.md`
- `docs/plans/2026-06-08-07-09-32-agent-check-clean-status.md`
- `docs/reports/dev/2026-06-08-07-09-32-agent-check-clean-status.md`
- `docs/reports/qa/2026-06-08-07-09-32-agent-check-clean-status.md`
- `scripts/agent-check.ps1`
- `docs/agent/PROMPT_USAGE.md`
- `docs/plans/2026-06-08-09-20-52-small-project-trial.md`
- `docs/reports/dev/2026-06-08-09-45-00-small-project-trial.md`
- `docs/reports/qa/2026-06-08-09-45-00-small-project-trial.md`
- `docs/reports/review/2026-06-08-09-45-00-small-project-trial.md`
- `docs/reports/delivery/2026-06-08-09-45-00-small-project-trial.md`
- `docs/handoffs/2026-06-08-09-45-00-small-project-trial.md`
- `docs/plans/2026-06-08-08-40-29-prompt-usage-and-forward-test.md`
- `docs/reports/dev/2026-06-08-08-40-29-prompt-usage-and-forward-test.md`
- `docs/reports/qa/2026-06-08-08-40-29-prompt-usage-and-forward-test.md`
- `docs/plans/2026-06-08-06-43-37-project-agent-skill.md`
- `docs/reports/dev/2026-06-08-06-43-37-project-agent-skill.md`
- `docs/reports/qa/2026-06-08-06-43-37-project-agent-skill.md`
- `docs/plans/2026-06-08-05-26-41-agent-templates-and-check.md`
- `docs/reports/dev/2026-06-08-05-42-28-agent-templates-and-check.md`
- `docs/reports/qa/2026-06-08-05-42-28-agent-templates-and-check.md`

Recent direction:

- File naming for timestamped artifacts should use
  `YYYY-MM-DD-HH-MM-SS-task-slug`.
- `AGENTS.md` should stay focused on behavior rules.
- `docs/agent/DIRECTORY_STRUCTURE.md` should own detailed path and naming
  rules.
- Full templates and `agent-check.ps1` are now implemented; the lightweight
  skill is implemented and validation has passed.

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
