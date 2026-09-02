# `/uiaudit` — аудит интерфейса

Read-only аудит UI/UX, accessibility, responsive, visual system, UI architecture и интерфейсных текстов.

1. Определить Fast/Adaptive/Deep.
2. Выполнить Rule Router: минимум `ui-design-system`; при CSS — `css-architecture`; при legacy modal/render/lifecycle — также `development-rules`.
3. Читать `audit-engine.md` и `ui-audit.md`; writing profile остаётся обязательным для `/uiaudit` по решению владельца Skill; при React/Next.js также `react-audit.md`.
4. Если приложение доступно, пройти real key flows и получить проверенные screenshots. Иначе static UI audit с ограничением.
5. Проверить applicable states, desktop/mobile/zoom, keyboard/focus, labels/errors/localization.
6. Сопоставить visual symptoms с owner в code/CSS; не предлагать новый override поверх root cause.
7. Вернуть verdict, P0–P3, quick wins и `NOT_ASSESSED`.

Ничего не менять без запроса. При «проверь и исправь UI» после evidence-backed отчёта перейти к `/apply` и провести visual regression check.
