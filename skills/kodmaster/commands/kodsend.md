# `/kodsend` — согласованная задача в Codex

Natural-language equivalents: «отправляй в Codex», «поставь задачу Codex», «запускай в отдельной ветке».

Разрешено только при актуальном согласованном плане. Если плана нет — выполнить `/kodplan` и остановиться.

1. Выполнить Git/GitHub/production preflight из `rules/codex-orchestration.md`.
2. Защитить dirty worktree и создать task branch от актуального `main`.
3. Сформировать компактный task package: цель, scope/non-goals, assumptions, Fast/Adaptive/Deep, применимые playbooks, acceptance criteria, проверки и stop conditions. Не передавать весь чат.
4. Реально вызвать доступный Codex/thread relay; не заявлять «отправлено» без tool evidence.
5. После результата выполнить `/kodaudit` Acceptance по реальному diff.
6. При REWORK передать только подтверждённый дефект и нужный контекст.
7. При GO merge/push/deploy допустимы лишь если этот lifecycle был явно согласован и production path подтверждён.

Не создавать Pull Request в single-developer workflow, если пользователь не попросил. Не выдумывать deploy/rollback команды.
