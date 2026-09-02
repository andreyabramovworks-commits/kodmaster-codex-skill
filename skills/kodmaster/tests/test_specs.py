#!/usr/bin/env python3
from pathlib import Path
import json

ROOT = Path(__file__).resolve().parents[1]

def require(path: str, needle: str):
    text=(ROOT/path).read_text(encoding='utf-8')
    assert needle in text, f'{path} missing {needle}'

def main():
    routing=json.loads((ROOT/'tests/routing_cases.json').read_text(encoding='utf-8'))
    rules=json.loads((ROOT/'tests/rule_router_cases.json').read_text(encoding='utf-8'))
    assert len(routing) >= 7
    assert len(rules) >= 8

    # Help must expose both slash commands and natural-language phrases.
    for needle in ['/kodplan','/apply','/kodsend','/kodaudit','/uiaudit','/fast','/deep','сделай план','исправь','отправляй в Codex','проверь приложение','проверь интерфейс']:
        require('commands/kodhelp.md', needle)

    # Rule router must include all critical packs and optional technology profiles.
    for needle in ['rules/core.md','rules/clean-code.md','rules/code-reuse.md','rules/testing.md','rules/security.md','rules/database.md','rules/api-integrations.md','rules/performance.md','rules/css-architecture.md','rules/ui-design-system.md','rules/codex-orchestration.md']:
        require('references/rule-router.md', needle)

    for needle in ['background-jobs-and-queues.md','caching.md','file-uploads-and-storage.md','realtime.md','browser-state-and-session.md']:
        require('SKILL.md', needle)

    # Context policy must explicitly prefer safety/completeness over token savings.
    require('rules/context-management.md','Не пропустить применимое обязательное правило')
    require('SKILL.md','Никакой внутренний лимит токенов не может отменить чтение нужного правила')

    # Removed duplicate rule files must stay removed.
    assert not (ROOT/'rules/css-ui-architecture.md').exists()
    assert not (ROOT/'rules/database-and-integrations.md').exists()

    print('SPEC TESTS OK')

if __name__ == '__main__':
    main()
