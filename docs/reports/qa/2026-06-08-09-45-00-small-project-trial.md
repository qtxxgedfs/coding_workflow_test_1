# Small Project Trial QA Report

## Metadata

- Project Slug: coding-workflow-test-1
- Task Slug: small-project-trial
- Created: 2026-06-08-09-45-00
- Owner Mode: QA
- Related Plan: `docs/plans/2026-06-08-09-20-52-small-project-trial.md`
- Status: pass

## Summary

QA verified that item 10 produced a real small project, a compact agent layer,
executable behavior tests, a lightweight check script, and a documented handoff.
The trial also surfaced one real process friction: a new thread can read and
start from the project state quickly, but a long active turn can make supervisor
intervention slow.

## Scenarios Tested

| Scenario | Type | Result | Evidence |
| --- | --- | --- | --- |
| Fresh child thread reads main agent layer. | forward-test | passed | Thread `019ea763-cd61-7941-a71c-64c01593e59a` read the local skill and created the main plan plus small-project skeleton. |
| Small project has its own agent layer. | happy path | passed | `AGENTS.md`, `PROJECT_STATE.md`, local skill, plans, ADR, reports, handoff, and check script exist. |
| Static app has real behavior. | happy path | passed | App supports sample data, create, edit, delete, filter, search, sort, reset, counts, and persistence functions. |
| Behavior is command-testable. | regression | passed | `node tests\app.test.mjs` passed. |
| Documentation contract is mechanically checked. | regression | passed | Small `agent-check.ps1` regular and strict checks passed. |
| Static files can be locally served. | smoke | passed | Temporary Node server returned expected `index.html`, `app.js`, and `styles.css` content. |
| Browser automation smoke test. | happy path | passed | Codex in-app Browser verified create, filter, reload, and real browser persistence through `http://127.0.0.1:4173/`. |
| Small project was committed locally. | delivery | passed | Commit `3a77779` created in `new_1_test_1`. |

## Commands

| Command | Result | Notes |
| --- | --- | --- |
| `node --check app.js` in small project | passed | JavaScript syntax valid. |
| `node tests\app.test.mjs` in small project | passed | Printed `app behavior tests passed`. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1` in small project | passed | 25 checks, 0 warnings. |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\agent-check.ps1 -Strict` in small project | passed | 40 checks, 0 warnings. |
| `node <temporary static server smoke script>` in small project | passed | Served static files and verified expected content. |
| `playwright browser smoke script` | blocked | `Cannot find module 'playwright-core'`. |
| `Codex in-app Browser smoke via http://127.0.0.1:4173/` in small project | passed | Initial 4 cards, after add 5, filtered 2, reload preserved created item. |
| `git commit -m "Build decision triage board trial"` in small project | passed | Created commit `3a77779`. |

## Results

- Item 10 is functionally complete.
- The small project proves the system is useful for supervised resumability.
- The strongest artifacts were `PROJECT_STATE.md`, plan, QA report, handoff,
  and `agent-check.ps1`.
- The full artifact chain is somewhat heavy for a tiny app, but acceptable
  because the trial intentionally exercised every layer.
- Browser evidence is now sufficient for the primary UI path despite the
  separate `playwright-core` package issue.

## Residual Risk

The UI still lacks full accessibility, multi-browser, and visual regression
coverage.
