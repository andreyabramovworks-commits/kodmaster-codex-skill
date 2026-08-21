#!/usr/bin/env python3
"""Create .codex project memory templates without overwriting existing files."""

from __future__ import annotations

import argparse
import shutil
from pathlib import Path


def copy_if_missing(source: Path, destination: Path) -> str:
    if destination.exists():
        return f"SKIP {destination} already exists"
    destination.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, destination)
    return f"CREATE {destination}"


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("repository", nargs="?", default=".")
    parser.add_argument(
        "--skill-root",
        default=str(Path(__file__).resolve().parents[1]),
        help="Path to kodmaster skill root",
    )
    args = parser.parse_args()

    repository = Path(args.repository).resolve()
    skill_root = Path(args.skill_root).resolve()

    if not repository.exists() or not repository.is_dir():
        raise SystemExit(f"Repository directory not found: {repository}")

    mappings = [
        (skill_root / "templates" / "project-memory.md", repository / ".codex" / "project-memory.md"),
        (skill_root / "templates" / "decisions.md", repository / ".codex" / "decisions.md"),
    ]

    for source, destination in mappings:
        if not source.exists():
            raise SystemExit(f"Template not found: {source}")
        print(copy_if_missing(source, destination))

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
