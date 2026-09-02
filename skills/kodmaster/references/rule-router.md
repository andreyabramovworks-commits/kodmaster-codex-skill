# Rule Router

Rule Router определяет, какие обязательные правила нужно прочитать перед планом, изменением или аудитом. Его задача — не минимизировать чтение любой ценой, а не пропустить применимое правило.

## Базовое правило

Всегда читать `rules/core.md` и файл выбранной команды.

Если сигнал неоднозначен, но последствия ошибки могут затронуть correctness, security, data, shared UI или production, подключить дополнительный rule pack. Ошибка «прочитали один лишний pack» предпочтительнее ошибки «не прочитали нужное правило».

## Матрица

| Сигнал в задаче или коде | Обязательные rule packs |
| --- | --- |
| Любая задача, которая меняет код (`/apply`, `/kodsend`) | `rules/clean-code.md`, `rules/code-reuse.md`, `rules/testing.md` |
| Новая логика, service, helper, refactor | `rules/clean-code.md`, `rules/code-reuse.md` |
| Тесты, баг, regression, flaky | `rules/testing.md` |
| Auth, roles, user input, secrets, uploads, permissions | `rules/security.md` |
| PostgreSQL, SQL, Supabase, schema, migration, transaction | `rules/database.md`, `rules/testing.md` |
| API, webhook, OAuth, Bitrix24, external service | `rules/api-integrations.md`, `rules/security.md`, `rules/testing.md` |
| Performance, heavy query, bundle, memory, latency | `rules/performance.md` |
| CSS, layout, component styling | `rules/css-architecture.md`, `rules/ui-design-system.md` |
| Legacy CSS, modal/overlay, competing render/load/bind | `rules/css-architecture.md`, `rules/ui-design-system.md`, `rules/development-rules.md` |
| Любое существенное UI изменение | `rules/ui-design-system.md`, `rules/testing.md` |
| Commit/push/deploy/CI/Docker/main | `rules/development-rules.md`, `rules/development-workflow.md` |
| `/kodsend`, Codex branch lifecycle | `rules/codex-orchestration.md`, `rules/development-workflow.md`, `rules/development-rules.md` |
| Queue/worker/background job | `rules/testing.md`, `rules/api-integrations.md` при внешнем I/O |
| Cache/Redis | `rules/testing.md`, `rules/security.md` если данные tenant/user-specific |
| File upload/storage | `rules/security.md`, `rules/testing.md` |
| WebSocket/SSE/realtime | `rules/testing.md`, `rules/security.md` если auth/session |
| Browser state/session/token lifecycle | `rules/security.md`, `rules/testing.md` |

## Повторная маршрутизация

После чтения кода повторить Rule Router, если найден новый слой:

- UI → API;
- API → DB;
- DB → migration;
- frontend → browser storage;
- request handler → queue/worker;
- feature → cache;
- local fix → shared component;
- branch work → deploy.

Новый слой нельзя менять до загрузки его rule pack.

## Fast / Adaptive / Deep

- Fast ограничивает scope кода, но не отменяет обязательные правила.
- Adaptive читает все вероятно применимые правила и расширяет набор по доказательствам.
- Deep сначала строит карту стека и затем читает все применимые rule packs. Явно отсутствующие технологии можно не читать.
