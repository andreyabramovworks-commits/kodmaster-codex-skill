# Security Rules

Этот файл является единым каноническим обязательным security-контрактом. Методика поиска уязвимостей остаётся в `references/technical-audit.md`.

## Secrets and sensitive data

- Запрещены пароли, API keys, OAuth/session tokens, cookies, SSH/private keys и приватные сертификаты в Git.
- Не повторять найденный секрет в ответе, логах или отчёте; сообщить тип проблемы и рекомендовать ротацию.
- Не переносить секреты из HAR, logs, browser storage или конфигурации в код.

## Auth and authorization

- Не ослаблять AuthN/AuthZ, role checks, tenant isolation или validation ради устранения симптома.
- Проверять серверную авторизацию для защищённых действий; UI-hidden control не является защитой.
- Для session/token lifecycle учитывать expiry, refresh, logout и invalidation.

## Input and output

- Валидировать пользовательский ввод на доверенной стороне.
- Экранировать/кодировать output в правильном контексте.
- Для uploads проверять тип, размер, путь/имя и доступ в соответствии с профилем storage.

## Dangerous actions

- Не выполнять destructive commands, активный pentest production, force push или разрушительные migration без отдельного явного разрешения.
- Не публиковать exploit payloads, чувствительные PII или рабочие credential values.

## Dependencies and CI

- Проверять новые зависимости на реальную необходимость, provenance/maintenance и известные уязвимости доступными средствами.
- CI secrets и токены должны иметь минимально необходимые права.
