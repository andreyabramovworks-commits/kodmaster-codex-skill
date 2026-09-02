# Testing Rules

Проверки выбираются по риску и должны ловить регрессию на самом низком надёжном уровне.

- unit — чистая логика, boundary conditions;
- integration — API, БД, очередь, filesystem, несколько модулей;
- component — UI states и поведение;
- E2E — критический пользовательский путь;
- property/fuzz — парсеры, сериализация и сложные инварианты;
- characterization — legacy-поведение перед безопасным рефакторингом.

Для бага по возможности сначала получить красное воспроизведение, затем зелёный результат после исправления.

Проверять применимые: happy path, empty/boundary, invalid input, permission denied, timeout/retry, partial failure, duplicate/idempotent request и concurrency.

Focused test → связанный suite → lint/typecheck/build по риску. Не запускать тяжёлые проверки механически для простой правки, но и не сокращать обязательную проверку критического изменения ради экономии.

Если тест или проверка недоступны, явно указать причину и остаточный риск.
