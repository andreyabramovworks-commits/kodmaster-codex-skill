# Маршрутизация и глубина

## Natural-language router

Определяй действие по смыслу, включая формы слов и английские эквиваленты. Не требуй `$kodmaster` или slash-команду.

| Намерение | Маршрут |
| --- | --- |
| «проверь всё приложение», «найди баги/ошибки» | `/kodaudit` Discovery |
| «проверь, что Codex сделал», «можно сливать?» | `/kodaudit` Acceptance |
| «проверь интерфейс/мобильную версию/доступность» | `/uiaudit` |
| «почини/исправь/реализуй» | `/apply`; для бага сначала короткий Discovery |
| «сделай план/сначала разберись/ничего не меняй» | `/kodplan` |
| «отправь в Codex/в отдельную ветку» | `/kodsend`, только при согласованном плане |
| «переведи/проверь грамматику/улучши текст» | writing profile |

Если пользователь явно говорит «только анализ», запрещены изменения. Если говорит «найди и исправь», анализ и исправление входят в одну задачу, но сохраняют отдельные фазы.

## Fast

Fast ограничивает кодовый scope: указанные файлы/сценарий, прямые imports/callers/callees/contracts, дешёвые статические проверки и минимальные тесты. Fast не отменяет обязательные rule packs из Rule Router.

## Deep

Deep означает полный проход, а не «подумать подольше»:

1. Инвентаризация корня, языков, manifests/lockfiles, entrypoints, apps/services, БД, CI/CD и deploy.
2. Карта runtime flows и trust boundaries.
3. Определение технологий и повторный Rule Router.
4. Все применимые технические tracks и rule packs.
5. Реальные пользовательские сценарии/UI states, если доступны.
6. Tests/build/linters/safe scanners.
7. Variant sweep.
8. `NOT_ASSESSED` с причиной.

Не сканировать binaries/vendor/generated/coverage/build output без специальной причины.

## Adaptive

Начни с дешёвой карты и risk signals. Расширяй scope при auth/payments/permissions/PII/secrets, migrations/concurrency/queues, public API/external integrations, shared helper, critical path без tests, рассинхроне docs/CI/runtime или новом техническом слое.

## Экономия контекста

- Сначала filenames/manifests/configs, затем релевантные файлы.
- Хранить короткий candidate ledger: id, evidence, status, next check.
- Не повторять одну первопричину для каждого симптома.
- Не вставлять длинные logs/source, если достаточно path/line и краткого фрагмента.
- Тяжёлые проверки запускать после дешёвого отбора и по риску.
- Правила важнее экономии: нужный rule pack нельзя пропускать ради token saving.
