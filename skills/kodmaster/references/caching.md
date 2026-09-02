# Caching / Redis Audit Profile

Применять только если реально найден cache: Redis, application cache, CDN cache, browser/server cache или аналог.

## Correctness first

Кэш — производная копия данных, а не новый источник истины без отдельного решения. Проверить, что stale data не нарушает бизнес-правила.

## Invalidation

Для каждого cached value определить: кто создаёт, key, TTL, кто инвалидирует/обновляет после write, что происходит при partial failure.

## Keys and isolation

User/tenant-specific cache key должен включать достаточную область владения. Нельзя допускать выдачу данных одного пользователя/tenant другому из-за общего key.

## Stampede

При истечении популярного key тысячи запросов не должны одновременно перегружать DB/API. При необходимости использовать locking/single-flight, stale-while-revalidate, jittered TTL или другой проектный механизм.

## TTL

TTL должен соответствовать цене устаревания. Бесконечный cache без invalidation допустим только для реально неизменяемых данных.

## Failure mode

Недоступность cache обычно не должна разрушать приложение, если cache не является сознательно критическим state store. Fallback не должен создавать лавину запросов.

## Verification

Проверить hit/miss, invalidation после write, concurrent miss, tenant isolation и поведение при Redis/cache outage, если применимо.
