# WebSocket / SSE / Realtime

Optional profile. Читать только если реально найден WebSocket, Socket.IO, Server-Sent Events, subscriptions или другой realtime transport.

## Connection lifecycle

Проверять connect, disconnect, reconnect, exponential backoff/jitter и cleanup при уходе со screen/component.

## Duplicate and ordering

После reconnect/retry одно событие может прийти повторно. Consumer должен безопасно обрабатывать duplicates, если transport это допускает. Если порядок важен, проверить sequence/version/timestamp strategy и поведение при out-of-order events.

## Stale subscriptions

Старая subscription/listener не должна продолжать жить после смены route/user/tenant. Проверять cleanup и повторное подключение без накопления listeners.

## Auth/session

Проверить авторизацию handshake/subscription, expiry/refresh token, logout/revocation и tenant/channel authorization. Смена пользователя не должна сохранять подписки предыдущего.

## Backpressure

Если producer быстрее consumer, система должна иметь понятную стратегию: buffer limits, drop/coalesce, batching или disconnect/recovery. Нельзя допускать неограниченный рост памяти.

## Recovery

После reconnect клиент должен восстановить актуальное state без двойного применения событий. При необходимости использовать snapshot + cursor/version/resume token.
