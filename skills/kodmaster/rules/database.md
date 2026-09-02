# Database Rules — PostgreSQL / Supabase / Migrations

Этот файл объединяет обязательные правила БД из прежних `development-rules` и `database-and-integrations`.

## Schema and migrations

- Изменение структуры PostgreSQL выполнять через migration-механизм проекта; для проектов с Alembic — только через Alembic.
- Не редактировать production-схему вручную.
- Не скрывать schema change внутри обычного application-кода.
- Migration должна иметь понятный upgrade и безопасный downgrade, если проект его поддерживает.
- Учитывать существующие данные, lock/table rewrite risk и backward compatibility при поэтапном deploy.
- Breaking change предпочтительно выполнять по схеме expand → backfill → switch → contract.

## Data integrity

- PK/FK/UNIQUE/NOT NULL/CHECK/defaults должны отражать реальные инварианты.
- Деньги и точные значения не хранить в float.
- Время хранить с корректной timezone-моделью.
- Tenant/user ownership должен сохраняться во всех необходимых связях.

## Queries and indexes

- Избегать N+1, unbounded scans и критических `SELECT *`.
- Индексы должны соответствовать реальным WHERE/JOIN/ORDER BY и оцениваться по цене записи.
- Для больших изменяемых наборов рассматривать cursor/keyset pagination.

## Transactions and concurrency

- Критические multi-step writes должны быть атомарны.
- Транзакции держать короткими; внешний I/O не выполнять под lock без сильной причины.
- Повторяемые команды защищать idempotency/unique guard.
- Учитывать isolation, lock order и connection pool limits.

## Supabase

Если проект использует Supabase:

- RLS для публично доступных tenant/user tables;
- policies для SELECT/INSERT/UPDATE/DELETE должны проверять пользователя и tenant;
- service role/private keys не должны попадать в client;
- проверить обход через views/functions, `security definer`, `search_path`, Storage policies и Edge Functions.

## Validation

Миграции и запросы проверять локально или в безопасном тестовом окружении. Destructive migration или `EXPLAIN ANALYZE` на production без отдельного разрешения запрещены.
