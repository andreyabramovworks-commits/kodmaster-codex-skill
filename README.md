# KodMaster v4 — autonomous audit and development skill for Codex

[Русская версия](README.ru.md) · [Installation](INSTALL.md) · [Changelog](CHANGELOG.md) · [License](LICENSE)

KodMaster is a self-contained Agent Skill for OpenAI Codex and ChatGPT. It understands natural-language intent, plans work, audits complete applications, finds root causes, fixes bugs, verifies diffs, and audits UI/UX/accessibility without requiring the source skills it learned from.

## What it checks

- code correctness, architecture, APIs, errors and logging;
- security, secret leaks, dependencies and supply chain;
- PostgreSQL/Supabase, migrations, transactions and RLS;
- performance, reliability, tests, CI/CD and deployment paths;
- React/Next.js composition, rendering, bundles and motion;
- UI/UX, responsive states, WCAG risks and visual consistency;
- Russian/English grammar, translation, UI copy and style.

## Natural-language use

Slash commands are optional. The skill is intentionally discoverable through its description.

```text
Use KodMaster. Audit the entire application, find real bugs and broken scenarios. Deep. Do not change anything yet.
```

```text
Проверь интерфейс регистрации на компьютере и телефоне: UX, доступность, состояния ошибок и тексты.
```

```text
Найди первопричину ошибки оплаты, исправь её и добавь регрессионный тест.
```

## Three depth modes

- **Fast** — requested scope, direct dependencies and cheap checks.
- **Adaptive** — default, expands only when evidence and risk justify it.
- **Deep** — repository-wide map and every applicable audit track.

## Commands

| Command | Purpose |
| --- | --- |
| `/kodplan` | Read-only plan |
| `/kodaudit` | Discovery audit or acceptance review of an existing diff |
| `/uiaudit` | UI/UX/accessibility/visual/text audit |
| `/apply` | Implement the agreed work |
| `/kodsend` | Run an agreed Codex branch lifecycle |
| `/fast`, `/deep` | Depth modifiers |
| `/kodhelp` | Compact help |

`/audit` remains a hidden backward-compatible alias for `/kodaudit` Discovery.

## Install

### Windows / Codex

Download `kodmaster-v4-codex-windows.zip`, extract it, then double-click `install-kodmaster.cmd`. The installer validates the package and installs it to `%USERPROFILE%\.agents\skills\kodmaster`.

### PowerShell

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-kodmaster.ps1
```

### ChatGPT web

Download the clean `kodmaster-v4-skill.zip`, then open **Plugins → Skills → Create → Upload from computer** and select the ZIP. Local Codex skills and web skills are separate installations.

See [INSTALL.md](INSTALL.md) for updates, uninstall and troubleshooting.

## How it stays efficient

`skills/kodmaster/SKILL.md` is a compact intent router. Detailed playbooks live in `references/` and are loaded only when the detected stack and risk require them. Findings use evidence thresholds, root-cause deduplication and explicit `NOT_ASSESSED` limits.

## Methodology and independence

KodMaster includes adapted, self-contained methods informed by [Khasky Awesome Agent Skills](https://github.com/khasky/awesome-agent-skills), [Vercel Agent Skills](https://github.com/vercel-labs/agent-skills), [Vercel Web Interface Guidelines](https://github.com/vercel-labs/web-interface-guidelines), and Supabase/Postgres practices. Users do not need to install those skills. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## Contributing and repository safety

Anyone may download, use, fork and modify their own copy under MIT. Only the repository owner and explicitly authorized collaborators can write to this repository. Contributions arrive as reviewed pull requests; `CODEOWNERS` marks the owner for review.

## License

MIT © 2026 andreyabramovworks-commits.
