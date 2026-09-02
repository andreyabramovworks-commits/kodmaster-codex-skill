#!/usr/bin/env python3
"""Validate KodMaster v4.1 structure, routing, references and eval specs."""
from __future__ import annotations
import re, subprocess, sys
from pathlib import Path

REQUIRED = [
    'SKILL.md','agents/openai.yaml',
    'commands/kodplan.md','commands/kodhelp.md','commands/apply.md','commands/fast.md','commands/deep.md','commands/audit.md','commands/uiaudit.md','commands/kodsend.md','commands/kodaudit.md','commands/kodstatus.md','commands/context.md','commands/compress.md','commands/clean.md','commands/memory.md','commands/decisions.md',
    'references/routing-and-depth.md','references/rule-router.md','references/audit-engine.md','references/technical-audit.md','references/database-audit.md','references/debugging-and-tests.md','references/react-audit.md','references/ui-audit.md','references/writing-and-localization.md','references/methodology-sources.md','references/background-jobs-and-queues.md','references/caching.md','references/file-uploads-and-storage.md','references/realtime.md','references/browser-state-and-session.md',
    'rules/core.md','rules/clean-code.md','rules/code-reuse.md','rules/testing.md','rules/security.md','rules/database.md','rules/api-integrations.md','rules/performance.md','rules/css-architecture.md','rules/codex-orchestration.md','rules/context-management.md','rules/development-rules.md','rules/development-workflow.md','rules/ui-design-system.md',
    'docs/USER_GUIDE.md','docs/DOCUMENTATION.md','templates/audit-report.md','templates/ui-audit-report.md','scripts/init_project_memory.py','tests/test_specs.py','tests/routing_cases.json','tests/rule_router_cases.json'
]

def main():
    root=Path(__file__).resolve().parents[1]
    errors=[]
    for rel in REQUIRED:
        p=root/rel
        if not p.is_file(): errors.append(f'Missing: {rel}')
        elif p.stat().st_size == 0: errors.append(f'Empty: {rel}')
    skill=root/'SKILL.md'
    if skill.is_file():
        text=skill.read_text(encoding='utf-8')
        for phrase in ['name: kodmaster','version: 4.1.0','Rule Router','Context Loading Policy','Fast','Adaptive','Deep','/kodaudit','/uiaudit']:
            if phrase not in text: errors.append(f'SKILL.md missing: {phrase}')
        linked=set(re.findall(r'`((?:commands|references|rules|docs|templates)/[^`]+)`',text))
        for rel in sorted(linked):
            if not (root/rel).is_file(): errors.append(f'Broken SKILL.md link: {rel}')
    for obsolete in ['rules/css-ui-architecture.md','rules/database-and-integrations.md']:
        if (root/obsolete).exists(): errors.append(f'Obsolete duplicate remains: {obsolete}')
    if errors:
        print('VALIDATION FAILED')
        for e in errors: print('-',e)
        return 1
    r=subprocess.run([sys.executable,str(root/'tests/test_specs.py')],cwd=root)
    if r.returncode: return r.returncode
    print(f'VALIDATION OK: {len(REQUIRED)} required files')
    return 0

if __name__=='__main__':
    raise SystemExit(main())
