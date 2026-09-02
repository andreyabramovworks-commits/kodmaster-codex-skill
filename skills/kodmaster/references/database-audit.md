# PostgreSQL / Supabase Audit Profile

Обязательные правила разработки: `rules/database.md`. Этот файл описывает, как их проверять.

Проверить schema invariants, PK/FK/UNIQUE/NOT NULL/CHECK/defaults, tenant ownership, timezone/money types, cascades.

Для queries: N+1, SELECT *, unbounded scans, predicates, indexes под WHERE/JOIN/ORDER BY, pagination. EXPLAIN/ANALYZE только на безопасных данных.

Для concurrency: atomic multi-step writes, isolation/locks, stable lock order, short transactions, idempotency, connection pools.

Supabase: RLS, SELECT/INSERT/UPDATE/DELETE policies, service-role leakage, views/functions/security definer/search_path, Storage policies, Edge Functions.

Migrations: expand → backfill → switch → contract для breaking changes; large backfill chunked/resumable; DDL lock/table rewrite оценить до production.
