# UI/UX, accessibility и визуальный аудит

## Evidence first

Если приложение можно запустить или открыть, пройти реальный flow и собрать скриншоты каждого важного шага. Перед использованием проверить, что снимок не пустой, не loading/error wall и показывает правильное состояние. Если runtime недоступен, провести static code audit и честно назвать ограничение.

Для каждого шага фиксировать: действие, observed state, expected state, screenshot/DOM/code evidence и health. Скриншот доказывает визуальное состояние, но не keyboard/screen-reader поведение.

## Сценарии и состояния

- Happy path, first run, loading/skeleton, empty, error, offline/timeout, success, permission denied и destructive confirmation.
- Desktop, narrow mobile, zoom/reflow, long text, RU/EN expansion, touch и keyboard.
- Back/forward/deep link/refresh, duplicate submit, focus restore и scroll lock.
- Ясность следующего действия, feedback, предотвращение ошибок, consistency и recovery.

## Accessibility

- Семантическая структура, landmarks/headings, button/link semantics.
- Accessible name/label, instructions и programmatic error association.
- Полная keyboard-навигация, видимый focus, логичный порядок, focus trap/return у modal.
- Contrast, non-color cues, target size, alt text, captions и reduced motion.
- Dynamic content: live regions только при необходимости; status/error не должен теряться.
- Запускать доступные a11y scanners, но дополнять ручной keyboard и screen-reader проверкой. Не заявлять полное WCAG 2.1/2.2 compliance без достаточного покрытия.

## Визуальная система

- Иерархия, spacing, alignment, typography, density, contrast, tokens и consistency компонентов.
- Не маскировать CSS-дефект новым override layer; найти owner cascade/layout.
- Один экран/состояние имеет одного render/state/load owner.
- Overlay/modal/drawer использует единый viewport, safe-area, scroll и stacking contract.
- Проверить CLS, изображения с размерами, font loading, overflow, truncation и dark mode.

## React/UI footguns

Применить `react-audit.md`, если найден React/Next.js. Особое внимание: duplicate listeners/requests, hydration flicker, nested interactive controls, hover-only functionality, controlled/uncontrolled forms и unstable list keys.

## Формат результата

Сначала verdict и 3–7 самых важных изменений. Затем шаги flow со скриншотами и findings P0–P3. Для конкретной UI-правки полезна таблица `До | После | Почему`. В конце — что нельзя проверить без устройства, screen reader, аккаунта или production data.
