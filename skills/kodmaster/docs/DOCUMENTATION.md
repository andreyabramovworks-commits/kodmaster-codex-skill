# KodMaster v4 — техническая документация

## Назначение

KodMaster — автономный skill-router для планирования, реализации и evidence-based аудита. Он включает адаптированные методики внутри пакета и не зависит от наличия Awesome Agent Skills, Vercel Agent Skills или Supabase Skills у пользователя.

## Архитектура

```text
Natural-language intent / slash command
  → route: plan | technical audit | UI audit | apply | Codex lifecycle | writing
  → depth: Fast | Adaptive | Deep
  → progressive reference selection
  → evidence ledger and root-cause workflow
  → report / implementation / acceptance verdict
```

- `SKILL.md` — компактный router и инварианты.
- `commands/` — публичные действия и legacy aliases.
- `references/` — автономные conditional playbooks.
- `rules/` — development/UI/Git orchestration contracts.
- `templates/` — форматы планов и отчётов.
- `scripts/` — локальная валидация и project-memory helper.

## Единый `/kodaudit`

Discovery выполняет read-only поиск дефектов и возвращает `SHIP | FIX | BLOCK`. Acceptance проверяет существующий diff и возвращает `GO | REWORK | BLOCKED | EVIDENCE_REQUIRED`. Router различает их по наличию согласованной задачи и проверяемого diff. `/audit` сохранён только как legacy alias Discovery.

## Technical tracks

Architecture/contracts, correctness, API/errors/logging, security/leak, dependencies/supply chain, performance/reliability, DB/PostgreSQL/Supabase, tests, CI/CD/deploy и условные React/Next.js проверки.

## UI tracks

Реальные flows и screenshots, UX states, responsive/touch/keyboard, WCAG 2.1/2.2 risks, CSS/render ownership, visual system, motion/performance и UI copy/localization. Скриншотный аудит не выдаётся за полный screen-reader/WCAG аудит.

## Writing tracks

Advisory grammar review, document editing, RU→EN translation, English humanization and reference-based style mimic. Structural markup, code, links, identifiers and facts must be preserved.

## Token model

Fast загружает только route + обязательные профили. Adaptive начинает с дешёвой карты и расширяется при risk signals. Deep читает все применимые к найденному стеку профили и делает repository-wide coverage. Findings дедуплицируются по root cause; raw logs/source не дублируются.

## Safety model

Read-only diagnostics допустимы. Active pentest требует authorization/scope. Apply не включает commit/push/deploy. `/kodsend` разрешает Git/Codex/merge/deploy только в границах конкретной согласованной задачи и при подтверждённом production path.

## Проверка пакета

Из корня skill:

```powershell
python .\scripts\validate_skill.py
```

Validator проверяет обязательные файлы, metadata, ключевые возможности и внутренние ссылки.

## Источники и лицензии

Сводка методик — `references/methodology-sources.md`; обязательные уведомления — `THIRD_PARTY_NOTICES.md` в репозитории дистрибутива.
