# `/uiaudit` — аудит интерфейса

Read-only аудит UI/UX, accessibility, responsive, визуальной системы, React-поведения и интерфейсных текстов.

1. Определить Fast/Deep/Adaptive.
2. Прочитать `references/audit-engine.md`, `ui-audit.md` и `writing-and-localization.md`; при React/Next.js также `react-audit.md`.
3. Если приложение доступно, пройти реальные ключевые flow и получить проверенные скриншоты. Если нет — выполнить static UI audit и назвать ограничение.
4. Проверить happy/loading/empty/error/success/permission states, desktop/mobile/zoom, keyboard/focus, labels/errors и локализацию.
5. Сопоставить визуальные симптомы с owner в code/CSS; не предлагать новый override поверх первопричины.
6. Вернуть verdict, шаги flow, P0–P3, таблицу `До | После | Почему`, quick wins и `NOT_ASSESSED`.

Fast проверяет запрошенный экран/flow и его прямые компоненты. Deep проходит все обнаруженные основные маршруты, состояния, breakpoints и применимые a11y-проверки. По скриншотам нельзя заявлять полное WCAG-соответствие.

Ничего не менять без запроса на исправление. При «проверь и исправь UI» после evidence-backed отчёта перейти к `/apply` и обязательно провести visual regression check.
