# Доказательный Audit Engine

## Карта до находок

Зафиксировать commit/branch, dirty state, stack, entrypoints, package managers, lockfiles, test commands, CI и deploy config. Для Deep добавить modules/data flow/trust boundaries.

## Реестр кандидатов

`CANDIDATE → CONFIRMED | SAFE | NEEDS_VERIFICATION`.

Подтверждение требует нескольких связанных доказательств: конкретный pattern/guard/contract, достижимый path или failing scenario, неверный result/sink и при возможности test/trace/log/runtime fact. Проверять альтернативное объяснение. Нулевой grep не закрывает track.

## Приоритет

- P0 — потеря данных, полный outage, критический security bypass.
- P1 — поломка ключевого flow, серьёзные права/утечка, высокая вероятность production incident.
- P2 — существенный defect с workaround, reliability/performance/accessibility regression.
- P3 — локальное качество, понятность или будущий риск.

Указывать confidence 0–10. Слабые находки не выдавать за подтверждённые.

## Finding

1. P0–P3.
2. Evidence: file:line, command/scenario, observed vs expected.
3. Impact.
4. Root cause.
5. Minimal fix и что не надо менять.
6. Regression check.
7. Confidence.

Объединять симптомы с общей первопричиной.

## Verdicts

Discovery: `SHIP | FIX | BLOCK`.
Acceptance: `GO | REWORK | BLOCKED | EVIDENCE_REQUIRED`.

Acceptance начинается с base/head и реального diff. Прочитать все changed files либо явно перечислить пропущенные. Проверить scope creep, secrets, generated files, migrations, API contracts, tests/build/CI и rollback по риску.

В конце перечислять `NOT_ASSESSED`.
