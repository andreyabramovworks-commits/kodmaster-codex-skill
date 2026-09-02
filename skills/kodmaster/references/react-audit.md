# React / Next.js Audit Profile

Проверять реальные conventions и версию проекта.

- устранять request waterfalls, параллелить независимое;
- не тянуть тяжёлые bundles через ненужные barrel imports;
- dynamic import только для реально тяжёлых/редких веток;
- derived state вычислять при render, не синхронизировать лишним effect;
- не создавать component types внутри render;
- subscriptions/listeners должны иметь стабильный lifecycle и cleanup;
- проверять stale closures, dependency arrays, duplicate requests, hydration mismatch;
- избегать boolean-prop explosion, лишних abstractions и слишком широких provider interfaces;
- animation должна объяснять state/feedback, учитывать reduced motion;
- hover-only поведение не должно ломать touch;
- bundle analyzer/Web Vitals/React profiler использовать при доступности; micro-optimization без measurement не считать подтверждённой проблемой.
