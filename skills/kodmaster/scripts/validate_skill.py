#!/usr/bin/env python3
"""Validate KodMaster structure, metadata, references and legacy compatibility."""

from __future__ import annotations

import re
from pathlib import Path

REQUIRED = [
    "SKILL.md", "LICENSE", "THIRD_PARTY_NOTICES.md",
    "agents/openai.yaml",
    "commands/kodplan.md", "commands/kodhelp.md", "commands/apply.md",
    "commands/fast.md", "commands/deep.md", "commands/audit.md",
    "commands/uiaudit.md", "commands/kodsend.md", "commands/kodaudit.md",
    "commands/kodstatus.md", "commands/context.md", "commands/compress.md",
    "commands/clean.md", "commands/memory.md", "commands/decisions.md",
    "references/routing-and-depth.md", "references/audit-engine.md",
    "references/technical-audit.md", "references/database-audit.md",
    "references/debugging-and-tests.md", "references/react-audit.md",
    "references/ui-audit.md", "references/writing-and-localization.md",
    "references/methodology-sources.md",
    "rules/development-rules.md", "rules/ui-design-system.md",
    "rules/codex-orchestration.md", "docs/USER_GUIDE.md",
    "docs/DOCUMENTATION.md", "templates/audit-report.md",
    "templates/ui-audit-report.md", "scripts/init_project_memory.py",
]


def main() -> int:
    root = Path(__file__).resolve().parents[1]
    errors: list[str] = []
    for relative in REQUIRED:
        path = root / relative
        if not path.is_file():
            errors.append(f"Missing: {relative}")
        elif path.stat().st_size == 0:
            errors.append(f"Empty: {relative}")

    skill = root / "SKILL.md"
    if skill.is_file():
        content = skill.read_text(encoding="utf-8")
        if not content.startswith("---\n"):
            errors.append("SKILL.md frontmatter must start on line 1")
        for phrase in [
            "name: kodmaster", "version: 4.0.0", "Fast", "Deep", "Adaptive",
            "/kodaudit", "/uiaudit", "совместимый алиас", "Progressive disclosure",
            "writing-and-localization.md",
        ]:
            if phrase not in content:
                errors.append(f"SKILL.md missing: {phrase}")

        linked = set(re.findall(r"`((?:commands|references|rules|docs|templates)/[^`]+)`", content))
        for relative in sorted(linked):
            if not (root / relative).is_file():
                errors.append(f"Broken SKILL.md link: {relative}")

    if errors:
        print("VALIDATION FAILED")
        for error in errors:
            print(f"- {error}")
        return 1
    print(f"VALIDATION OK: {len(REQUIRED)} required files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
