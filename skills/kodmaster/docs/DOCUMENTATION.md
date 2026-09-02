# KodMaster v4.1 — архитектура

## Главная схема

`User intent → command router → Rule Router → mandatory rule packs → reference profiles → work/audit → evidence → result`.

Для Codex lifecycle:

`ChatGPT/KodMaster → /kodplan → /kodsend → task branch → Codex → Acceptance → REWORK/GO → main → production`.

## Почему появился Rule Router

Раньше большие файлы правил существовали, но progressive disclosure гарантированно маршрутизировал в основном reference-профили. v4.1 отделяет два вопроса:

1. **Что делать?** — command/intent router.
2. **Какие обязательные правила прочитать?** — Rule Router.

Rule Router повторяется при обнаружении нового слоя системы.

## Канонические rule packs

- `rules/core.md` — всегда;
- `rules/clean-code.md` — ответственность модулей;
- `rules/code-reuse.md` — переиспользование;
- `rules/testing.md` — тесты и risk-based verification;
- `rules/security.md` — единый security contract;
- `rules/database.md` — единый DB/PostgreSQL/Supabase contract;
- `rules/api-integrations.md` — API/webhooks/OAuth/external services;
- `rules/performance.md` — performance;
- `rules/css-architecture.md` — CSS и legacy normalization;
- `rules/ui-design-system.md` — UI/UX/a11y;
- `rules/development-rules.md` — shared workflow, delivery и legacy UI contracts;
- `rules/development-workflow.md` — Git/main/production workflow;
- `rules/codex-orchestration.md` — ChatGPT ↔ Codex orchestration.

Удалены дублирующие файлы `css-ui-architecture.md` и `database-and-integrations.md`. Clean Code и Code Reuse оставлены отдельными каноническими packs вместо повторения полного текста внутри development rules.

По решению владельца Modal Contract, Single UI Ownership и Visual Preservation остаются также в существующем UI/development контуре.

## Context Loading Policy

Экономия токенов вторична по отношению к полноте применимых правил. Жёсткого token cap нет.

Fast/Adaptive/Deep управляют объёмом code/reference context, но не отменяют mandatory rules. При сомнении о rule pack, влияющем на correctness/security/data/deploy, pack читается.

## Audit Profiles

Базовые: audit engine, technical audit, debugging/tests, database, React, UI/a11y, writing/localization.

Optional v4.1: background jobs/queues, caching, file uploads/storage, realtime, browser state/session.

## Automated skill checks

`tests/test_specs.py` проверяет:

- наличие команд и natural-language equivalents в `/kodhelp`;
- наличие обязательных rule packs в Rule Router;
- наличие optional profiles;
- safety-first Context Loading Policy;
- отсутствие двух удалённых duplicate rule files.

`tests/routing_cases.json` и `tests/rule_router_cases.json` являются machine-readable forward-test наборами для маршрутизации.

`scripts/validate_skill.py` проверяет структуру, ссылки и запускает spec tests.
