# UI/UX, Accessibility and Visual Audit

Если приложение доступно, пройти реальный flow и собрать проверенные screenshots важных шагов. Если runtime недоступен — static audit с честным ограничением.

Проверять применимые states: happy path, first run, loading, empty, error, timeout/offline, success, permission denied, destructive confirmation. Проверять desktop/mobile/zoom, long text, RU/EN expansion, touch/keyboard, back/forward/deep link/refresh, duplicate submit, focus restore и scroll lock.

Accessibility: semantics, headings/landmarks, labels/accessible names, programmatic errors, keyboard, visible focus, modal focus trap/return, contrast, non-color cues, target size, alt/captions, reduced motion. Scanner не заменяет manual keyboard/screen-reader verification.

Visual system: hierarchy, spacing, alignment, typography, density, contrast, tokens/components. CSS owner/cascade проверять по `rules/css-architecture.md`. Legacy modal/render ownership/visual preservation — по `rules/ui-design-system.md` и `rules/development-rules.md`.

React/Next.js → дополнительно `react-audit.md`.

Формат: verdict, 3–7 ключевых улучшений, evidence, P0–P3, `NOT_ASSESSED`. Для локальной правки не превращать проверку в полный редизайн.
