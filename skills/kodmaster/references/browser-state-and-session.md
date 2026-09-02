# Browser State and Session

Применять если проект использует localStorage, sessionStorage, IndexedDB, cookies/client session cache, service worker state или cross-tab synchronization.

## Ownership and sensitivity

Определить, какие данные принадлежат конкретному user/tenant/session. Чувствительные данные и access tokens не хранить в доступном JavaScript storage без архитектурной необходимости и анализа риска.

## Login / logout

При logout очищать или инвалидировать user-specific client state. После входа другим пользователем UI не должен кратковременно показывать данные предыдущего аккаунта.

## Token lifecycle

Проверить expiry, refresh, failed refresh, logout, revocation и одновременные запросы во время refresh. Не допускать бесконечной refresh-loop.

## Stale tabs

Несколько вкладок могут иметь разные версии state. Проверять реакцию на logout/login, смену tenant, изменение критических данных и schema/version client storage. При необходимости использовать storage events/BroadcastChannel/другой проектный механизм.

## IndexedDB / migrations

Для versioned browser DB учитывать upgrade path, partial failure, old schema и cleanup устаревших данных.

## Offline/stale state

Если UI может работать offline или долго жить без reload, определить правила freshness, conflict resolution и recovery после reconnect.
