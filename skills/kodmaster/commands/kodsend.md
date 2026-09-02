# `/kodsend` — согласованная задача в Codex

Natural language: «отправляй в Codex», «поставь задачу Codex», «запускай в отдельной ветке».

Только при актуальном согласованном плане. Если плана нет — выполнить `/kodplan` и остановиться.

1. Выполнить Rule Router для всей согласованной задачи.
2. Git/GitHub/production preflight из `rules/codex-orchestration.md`.
3. Защитить dirty worktree и создать task branch от актуального `main`.
4. Сформировать compact task package: цель, scope/non-goals, assumptions, depth, обязательные rule packs, acceptance criteria, checks, stop conditions. Не передавать весь чат.
5. Реально вызвать доступный Codex/relay; не заявлять «отправлено» без evidence.
6. После результата `/kodaudit` Acceptance по real diff.
7. REWORK передаёт только подтверждённый новый defect и нужный context.
8. GO → merge/push/deploy только в рамках уже авторизованного lifecycle и подтверждённого production path.

Pull Request не нужен в стандартном single-developer workflow.
