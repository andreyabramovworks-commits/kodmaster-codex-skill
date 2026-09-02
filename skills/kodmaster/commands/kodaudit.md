# `/kodaudit` — единый технический аудит

Команда автоматически выбирает Discovery или Acceptance.

Перед аудитом: выбрать Fast/Adaptive/Deep, выполнить Rule Router и загрузить обязательные rule packs.

## Discovery

1. Read-only карта scope и применимых tracks.
2. `audit-engine.md`, `technical-audit.md` и условные profiles стека.
3. Runtime/tests/build только безопасными действиями.
4. Подтвердить candidates, сгруппировать по root cause.
5. Вернуть `SHIP | FIX | BLOCK`, P0–P3 и `NOT_ASSESSED`.

Не исправлять код при запросе только аудита. При «найди и исправь» после Discovery перейти к `/apply`.

## Acceptance

1. Base/head, dirty state и реальный diff.
2. Все changed files или явный список пропущенных.
3. Сопоставить diff с acceptance criteria/non-goals.
4. Повторно выполнить Rule Router по фактически изменённым слоям.
5. Проверить correctness/security/tests/migrations/API/UI/deploy по риску.
6. Вернуть только `GO | REWORK | BLOCKED | EVIDENCE_REQUIRED` с доказательствами.

Сам `/kodaudit` ничего не публикует.
