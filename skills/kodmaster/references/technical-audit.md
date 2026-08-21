# Технический аудит

Выбирать треки по стеку. В Deep пройти каждый применимый трек; неприменимый или недоступный явно отметить.

## Архитектура и контракты

- Сопоставить документацию с реальными командами build/test/run.
- Проверить границы модулей, направление зависимостей, циклы, глобальное состояние и extension seams.
- Проверить KISS/YAGNI/SOLID на конкретных последствиях, не по вкусу.
- Установить, можно ли собрать проект с нуля и добавить новый provider/adapter без каскадных изменений.
- Для API: существующие conventions, ресурсы вместо процедур, validation, versioning, pagination, idempotency, optimistic concurrency и единый machine-readable error contract.

## Корректность, ошибки и логирование

- Silent failures, swallowed exceptions, broad catch, неверные defaults, race conditions, timezone/locale, null/empty и partial state.
- Разделить operational и programmer errors; typed errors на внутренних границах.
- HTTP status/retryability не должны противоречить контракту.
- Structured logs: timestamp, level, event, request/trace id, outcome; редактировать secrets/PII.
- Проверить, что индуцированная безопасная ошибка даёт полезный log без утечки.

## Безопасность и утечки

- Нарисовать trust boundaries и применить STRIDE только к реальным потокам.
- AuthN/AuthZ, tenant isolation, injection, SSRF/path traversal, XSS/CSRF, insecure deserialization, uploads, crypto, secrets, CI tokens.
- Для public clients проверить necessary-minimum: bundles/source maps/configs/logs/agent files не должны раскрывать приватную инфраструктуру или лишние операции.
- Подтверждать vulnerability через source→sink и attacker-controlled input; классифицировать CWE/OWASP, не публикуя рабочие секреты.
- Passive checks допустимы. Active pentest живого target — только после явного разрешения, scope и правил engagement.

## Зависимости и supply chain

- Единственный согласованный lockfile, frozen install в CI, отсутствие неожиданных lockfile diffs.
- Проверить typosquat/slopsquat, provenance, maintenance, install scripts, dependency confusion и лицензии.
- CVE оценивать по версии, достижимости и реальному runtime path; scanner output — кандидат, не доказательство.
- Агентские плагины, actions, containers и build tools считать зависимостями.
- Обновления разбивать по риску; major отдельно; читать changelog; не использовать `--force` как исправление.

## Производительность и надёжность

- Не заявлять проблему без measurement или достижимого антипаттерна.
- Сервер: blocking/event loop, N+1, streaming/backpressure, memory/CPU, connection pools, timeouts, bounded retries, circuit breakers, graceful shutdown.
- Frontend: Core Web Vitals, bundle/chunks, waterfalls, hydration, expensive renders/listeners и image/font loading.
- Фиксировать p95/p99 и нагрузочный профиль, если доступны; иначе `NOT_ASSESSED`.

## CI/CD и эксплуатация

- Branch/required checks, least-privilege secrets, pinned actions/images, reproducible build и artifact provenance.
- Миграции и deploy должны иметь порядок, health checks и проверяемый rollback.
- Production не редактируется вручную; состояние релиза связывается с commit SHA/image digest.

## Cleanup

По умолчанию только аудит. Refactor/cleanup — отдельное разрешение. Комментарии классифицировать `DELETE | CONDENSE | FIX | KEEP`; сохранять load-bearing знания. Применять Chesterton’s fence и characterization tests к legacy.
