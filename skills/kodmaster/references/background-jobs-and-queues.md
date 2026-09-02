# Background Jobs and Queues

Применять только если в проекте реально есть Celery, RQ, Bull/BullMQ, Sidekiq, workers, cron/scheduled jobs, message broker или другой background execution.

## Модель доставки

Сначала определить, что гарантирует система: сообщение может прийти один раз, как минимум один раз или быть повторено после сбоя. Не предполагать exactly-once без доказательства.

## Idempotency

Повторный запуск одной logical job не должен повторно списывать деньги, создавать duplicate records, отправлять необратимую команду или ломать state. Для опасных операций использовать idempotency key, unique guard или transactional state machine.

## Retries

- retries должны быть bounded;
- transient и permanent errors различать;
- backoff/jitter применять при внешних временных сбоях;
- повторная попытка не должна создавать duplicate side effects.

## Poison jobs / Dead-letter

Job, которая стабильно падает, не должна бесконечно блокировать очередь. После ограниченного числа попыток её нужно изолировать/пометить/перевести в dead-letter или эквивалентный механизм проекта с понятной диагностикой.

## Worker lifecycle

Проверять crash/restart, graceful shutdown, visibility timeout/ack semantics, duplicate delivery после падения, зависшие jobs и корректность при deploy во время выполнения.

## Scheduling

Для cron/scheduled jobs проверять timezone, overlap, missed runs, duplicate runs и поведение после downtime.

## Observability

Нужны применимые: job id, type, attempt, duration, outcome, safe error context, queue lag/depth. Не логировать secrets/PII без необходимости.
