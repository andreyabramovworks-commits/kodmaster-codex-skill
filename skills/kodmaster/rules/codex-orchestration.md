# Codex Orchestration Rules

## 1. Roles

- ChatGPT + КодМастер: постановка, смысл, ограничения, план, приёмка.
- Codex: тяжёлая работа с кодовой базой и выполнение task package.
- GitHub: обязательный удалённый источник истории и мост между сторонами.

## 2. Mandatory GitHub Bootstrap

Перед первой Codex-задачей проект обязан иметь безопасно подтверждённый private GitHub repository, `origin`, production branch `main`, отсутствие секретов в Git и понятный deployment/rollback path.

Автоматически пытаться выполнить доступные безопасные действия. Остановиться при конфликтующем remote, отсутствии авторизации, риске потери истории, коллизии repository или неизвестном production path.

## 3. Branch per Task

Каждая Codex-задача выполняется в отдельной ветке от актуального `main`. Прямое изменение `main` Codex во время реализации запрещено.

## 4. No Pull Requests

Для стандартного workflow КодМастера v3 Pull Request не используется. Проект рассчитан на одного разработчика. Контроль обеспечивается task branch + audit gate + Git history + rollback.

## 5. Minimal Task Package

Передавать только согласованные: цель, scope, запреты, acceptance criteria, применимые правила, уровень риска и проверки. Не дублировать весь чат.

## 6. Evidence-based Audit

Решение принимается по diff, файлам, checks и acceptance criteria. Самоотчёт Codex не является доказательством.

## 7. GO / REWORK

- GO -> автоматический merge в main, push, production deployment, post-deploy verification.
- REWORK -> узкая повторная задача без пересказа исходного контекста.
- BLOCKED -> одна подтверждённая причина остановки.
- EVIDENCE_REQUIRED -> сначала получить недостающую проверку.

## 8. Automatic Merge to Main

Перед merge проверить актуальность `main` и отсутствие конфликтующих изменений. Merge выполняется только после GO. После merge сохранить новый main commit SHA.

## 9. Production

`main` является единственным production source. После push main использовать реально настроенный pipeline проекта. Не выдумывать deployment commands. Проверить artifact, health, migrations и затронутый сценарий. Rollback только через Git/Docker workflow.

## 10. Truthfulness

Не писать «отправлено в Codex», «деплой идёт» или «production обновлён» без фактического подтверждения от доступного инструмента/репозитория/pipeline. Если автоматическая доставка недоступна, честно вернуть одну команду для ручной передачи.

## 11. Token Economy

Сначала читать task package, diff и прямые зависимости. Расширять контекст только по обнаруженному риску. REWORK должен быть меньше исходной задачи и содержать только новый дефект.
