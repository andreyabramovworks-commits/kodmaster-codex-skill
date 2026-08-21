# React и Next.js

## Data flow и bundles

- Убирать последовательные waterfalls: запускать независимые операции параллельно, await — как можно позже.
- Не импортировать тяжёлые библиотеки через общий barrel, если это тянет лишний bundle.
- Dynamic import применять к реально тяжёлым/редким веткам, не дробить всё автоматически.
- Не передавать в Client Components данные и функции, которые там не нужны.

## Render correctness

- Derived state вычислять при render, а не синхронизировать лишним effect.
- Не создавать component types внутри render.
- Стабилизировать subscriptions/listeners и обязательно cleanup.
- Проверить stale closures, dependency arrays, duplicate requests и hydration mismatch.
- Большие списки: virtualization/content-visibility только при доказанной цене.

## Composition

- Boolean-prop explosion заменять явными variants или compound components.
- State provider публикует минимальный interface; UI не знает способ хранения состояния.
- Предпочитать composition/children и небольшие публичные seams; не добавлять абстракцию ради одного случая.
- Существующие React/Next.js conventions и версия имеют приоритет над общим советом.

## Interaction и motion

- Анимация должна объяснять связь/состояние/feedback; частые keyboard actions не задерживать.
- Для обычного UI предпочитать transform/opacity и interruptible transitions; избегать `transition: all`.
- Popover возникает от trigger origin; modal остаётся центрированным.
- Hover только для `(hover: hover) and (pointer: fine)`.
- `prefers-reduced-motion` уменьшает движение, сохраняя полезный feedback.
- View Transitions использовать только когда continuity между состояниями реально помогает; иметь fallback.

## Проверка

React DevTools/profile, bundle analyzer и Web Vitals использовать при доступности. Без measurement не выдавать micro-optimization за подтверждённую проблему.
