# Development Rules — v4.1 index and shared workflow

Этот файл больше не дублирует тематические правила. Он хранит общие правила разработки, delivery и legacy UI, а для вынесенных тем указывает канонический rule pack.

Обязательная загрузка определяется `references/rule-router.md`.

## 1. Source Code Management

Исходный код изменяется только в рабочем Git-репозитории. Запрещено редактировать production напрямую, использовать production как среду разработки или оставлять невоспроизводимые ручные правки.

## 2. Local Validation

Перед публикацией выполнить проверки, достаточные для изменённой области и риска. Если проверка недоступна, явно указать причину и остаточный риск. Полная стратегия: `rules/testing.md`.

## 3. Git Workflow

Для обычного `/apply` commit/push выполняются только по отдельному разрешению пользователя.

Для `/kodsend` сама команда является разрешением на lifecycle согласованной задачи: task branch → commit/push → Acceptance → GO → merge в `main` → push `main` → production workflow, если production path подтверждён.

## 4. Production Deployment

`main` является единственным источником production, если подтверждённая project memory не фиксирует другое.

## 5. Deployment Pipeline

Использовать реально настроенный pipeline проекта. Типичный путь может включать получение `main`, Docker build/restart, migrations и запуск приложения. Не выдумывать команды и не подменять pipeline ручным редактированием production.

## 6. Post-deployment Verification

После deploy проверить применимые: artifact/commit SHA, containers/processes, health endpoints, migrations, critical logs и изменённый пользовательский сценарий. Deploy нельзя считать завершённым только по успешному возврату одной команды.

## 7. Security

Канонический обязательный security-контракт: `rules/security.md`. Не дублировать его здесь.

## 8. Database

Канонические обязательные правила PostgreSQL/Supabase/migrations: `rules/database.md`. Не дублировать их здесь.

## 9. API and Integrations

Канонические правила API/webhooks/OAuth/Bitrix24/external services: `rules/api-integrations.md`.

## 10. CSS Architecture

Канонический источник: `rules/css-architecture.md`.

## 11. Code Reuse

Канонический источник: `rules/code-reuse.md`.

## 12. Clean Code

Канонический источник: `rules/clean-code.md`.

## 13. Deployment Artifact and Rollback

Каждый production deploy должен быть связан с конкретным commit SHA или неизменяемым image/artifact. До рискованного deploy должен существовать понятный rollback/forward-fix path. Rollback выполняется через Git/Docker/pipeline workflow, не ручным production patch.

После rollback повторно проверить health, migrations и затронутый сценарий.

## 14. Observability, Logs and Error Monitoring

Приложение должно иметь достаточную наблюдаемость для диагностики применимых проблем: structured logs, error logging, health checks и понятные user-facing errors. Логи не должны раскрывать secrets и необоснованные PII.

## 15. Dependency Management

Новые зависимости добавлять только при реальной необходимости. Использовать lockfiles и conventions проекта, избегать массовых несвязанных обновлений, проверять compatibility и доступную security information. Security-часть дополнительно регулируется `rules/security.md`.

## 16. API Contracts and Backward Compatibility

Полный contract: `rules/api-integrations.md`. Breaking changes должны быть явно выявлены и согласованы до реализации.

## 17. Test Strategy

Канонический источник: `rules/testing.md`.

## 18. External API Reliability

Канонический источник: `rules/api-integrations.md`.

## 19. Performance

Канонический источник: `rules/performance.md`.

## 20. UI Quality and Accessibility

Для существенных UI-задач обязателен `rules/ui-design-system.md`. Для CSS дополнительно `rules/css-architecture.md`.

## 21. Architecture Decision Records

Важные архитектурные решения кратко фиксировать в `.codex/decisions.md` или принятом проектом ADR-формате: проблема, выбранное решение, причины, альтернативы и последствия. Для мелких правок ADR не нужен.

## 22. CI Validation

Использовать существующий CI пропорционально риску: lint, formatting, typecheck, tests, production build, Docker build, security/dependency checks — только применимые. Если CI недоступен, выполнить доступные локальные проверки и явно указать остаточный риск.

## 23. Definition of Done

Изменение считается завершённым, когда код реализован, достаточные проверки пройдены, применимые migration/security requirements соблюдены и пользовательский сценарий проверен.

Для `/apply` полный delivery не подразумевается без отдельного разрешения. Для `/kodsend` после `GO` delivery входит в авторизованный lifecycle, если production path подтверждён.

## 24. CSS Legacy Normalization

Подробные CSS-правила находятся в `rules/css-architecture.md`. При legacy UI запрещено добавлять ещё один override layer поверх уже конфликтующего cascade. Сохранять текущий правильный визуальный результат и нормализовать затронутую область у канонического owner.

## 25. Modal / Overlay Viewport Contract

Все modal/dialog/drawer/overlay одного приложения должны иметь согласованный viewport-контракт и по возможности общий primitive.

Определить: viewport/safe area, max dimensions, одного scroll owner, header/body/footer, доступность actions, mobile behavior, Escape/close/focus management.

Не допускать без причины двойной вертикальный scroll, footer вне viewport, header за верхней границей и локальные несовместимые viewport hacks.

## 26. Single UI Ownership

Для одного screen/state должен существовать один канонический owner render/routing/state/loading/subscriptions/lifecycle.

Запрещены как постоянная архитектура: конкурирующие renderers, runtime monkey patches, повторные wrappers, `setTimeout`-инициализация вместо lifecycle, несколько independent full loads и повторные listeners без cleanup/idempotency.

Для legacy сначала построить `trigger -> load -> state -> render -> bind`, затем оставить один канонический сценарий и проверить отсутствие flicker, duplicate requests/listeners и промежуточного старого DOM.

## 27. Visual Preservation During Refactoring

Если пользователь не просил редизайн, подтверждённый текущий внешний вид и поведение являются контрактом.

Перед архитектурным UI-refactor по возможности зафиксировать relevant desktop/mobile screenshots, states и interactions. Можно менять внутреннюю реализацию, но нельзя самовольно менять цвета, композицию, типографику, размеры, spacing или пользовательский flow, кроме непосредственно исправляемого дефекта.

## 28. Codex Orchestration and Automatic Main Delivery

Для `/kodsend` обязательны `rules/codex-orchestration.md` и `rules/development-workflow.md`.

Lifecycle: mandatory GitHub preflight → отдельная task branch → compact task package → Codex → evidence-based Acceptance → REWORK/BLOCKED либо GO → automatic merge в `main` без PR → push `main` → production pipeline → post-deploy verification/rollback при подтверждённой регрессии.

Pull Request не является стандартным workflow для single-developer сценария, но task branch, audit gate, commit SHA/artifact и rollback обязательны.

## Risk-based checks

Низкий риск — локальные focused checks.
Средний — релевантные tests/typecheck/build затронутой части.
Высокий — полный применимый набор tests/build/Docker/migrations/security/dependency/post-deploy checks.

Это не token-saving loophole: обязательный rule pack читается независимо от уровня риска.
