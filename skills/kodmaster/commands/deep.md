# `/deep` — полный применимый проход

Deep означает полный анализ реально применимого стека, а не просто более долгое размышление.

1. Построить repository/stack map.
2. Выполнить Rule Router по найденным технологиям и потокам.
3. Прочитать все применимые rule packs.
4. Прочитать все применимые reference profiles.
5. Проверить architecture/runtime/data/UI/tests/CI/deploy в пределах доступного evidence.
6. Выполнить variant sweep и перечислить `NOT_ASSESSED`.

Deep не требует читать profile отсутствующей технологии. Например, если Redis/WebSocket/Supabase в проекте нет, их profile не загружается только ради формальной полноты.
