# Технический аудит

Выбирать tracks по реально найденному stack. В Deep пройти каждый применимый track и явно отметить недоступный.

## Architecture and contracts

Сопоставить docs с build/test/run. Проверить module boundaries, dependency direction/cycles, global state, extension seams и API conventions/contracts. KISS/YAGNI/SOLID оценивать по последствиям, не по вкусу.

## Correctness / errors / logs

Искать silent failures, swallowed exceptions, broad catch, wrong defaults, races, timezone/locale, null/empty, partial state. Разделять operational/programmer errors. Structured logs должны помогать диагностике и не раскрывать secrets/PII.

## Security methodology

Обязательный контракт находится в `rules/security.md`. Здесь методика поиска: trust boundaries, AuthN/AuthZ, tenant isolation, injection, SSRF/path traversal, XSS/CSRF, insecure deserialization, uploads, crypto, secrets, CI tokens. Подтверждать vulnerability через controllable input → transform → sink/impact. Passive checks допустимы; active pentest production — только с явным разрешением и scope.

## Dependencies / supply chain

Проверять lockfiles, frozen install, provenance, maintenance, install scripts, dependency confusion и licenses. CVE оценивать по версии, достижимости и runtime path; scanner output — кандидат, не доказательство.

## Performance / reliability

Не заявлять проблему без measurement или достижимого antipattern. Backend: event loop/blocking, N+1, pools, timeouts/retries, graceful shutdown. Frontend: Web Vitals, bundle/chunks, waterfalls, hydration, expensive renders/listeners.

## CI/CD

Branch/checks, least-privilege secrets, reproducible build/artifact provenance, migrations, health checks и rollback. Production не редактируется вручную.

## Cleanup

Audit read-only по умолчанию. Несвязанный refactor/cleanup требует отдельного разрешения. Для legacy применять characterization tests и сохранять load-bearing knowledge.
