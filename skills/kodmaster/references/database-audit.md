# PostgreSQL и Supabase

Применять к PostgreSQL в любом окружении; Supabase-специфику включать только если она есть в проекте.

## Схема и целостность

- Точные типы, PK/FK, UNIQUE, NOT NULL, CHECK и defaults отражают бизнес-инварианты.
- Не использовать EAV/generic key-value без доказанной необходимости.
- Тenant key присутствует во всех нужных связях; каскады удаления осознанны.
- Временные значения хранят timezone; деньги/точность не используют float.

## Запросы и индексы

- Нет `SELECT *` в критических путях, N+1, unbounded scans и unindexable predicates.
- Индексы следуют реальным WHERE/JOIN/ORDER BY и проверяются через EXPLAIN/ANALYZE на безопасных данных.
- Учитывать composite order, partial indexes, write amplification и unused indexes.
- Pagination предпочтительно cursor/keyset для больших/изменяемых наборов.

## Транзакции и concurrency

- Критические multi-step writes атомарны; isolation и locks соответствуют гонке.
- Lock order стабилен, транзакции короткие, external I/O не держит lock.
- Повторяемые команды имеют idempotency/unique guard.
- Connection pool имеет лимиты и не создаёт connection storm.

## RLS и Supabase

- RLS включён на публично доступных tenant/user tables.
- Policy проверяет пользователя и tenant для SELECT/INSERT/UPDATE/DELETE; service-role key не попадает в client.
- Проверить обход через views/functions, `security definer`, search_path, Storage policies и Edge Functions.
- Публичный anon key не считать секретом; service role и private keys — секреты.

## Миграции и эксплуатация

- Expand → backfill → switch → contract для breaking schema changes.
- Large backfill chunked/resumable; DDL lock и table rewrite оценены до production.
- Есть downgrade/forward-fix стратегия, backups и проверенный restore.
- Наблюдаемость: slow queries, locks, pool saturation, replication lag и storage growth.

Не запускать destructive migration или EXPLAIN ANALYZE на production без явного разрешения.
