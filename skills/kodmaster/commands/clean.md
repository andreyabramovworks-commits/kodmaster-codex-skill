# `/clean` — безопасная очистка

`/clean analyze` только показывает нумерованный список кандидатов и ничего не меняет. Проверять generated/vendor/migrations/lockfiles и dirty worktree; такие файлы по умолчанию исключить.

Код/комментарии классифицировать: `DELETE | CONDENSE | FIX | KEEP`. Перед удалением понять назначение (Chesterton’s fence), проверить references/callers/runtime loading и отличить unreachable от редко достижимого.

`/clean apply 1,3` изменяет только явно выбранные пункты, сохраняет поведение и запускает релевантные тесты. Большой рефакторинг, dependency removal и schema cleanup требуют отдельного плана.
