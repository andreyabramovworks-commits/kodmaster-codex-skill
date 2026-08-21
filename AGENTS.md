# Repository instructions

- The canonical skill lives in `skills/kodmaster/`.
- Preserve natural-language routing, Fast/Adaptive/Deep semantics and the Discovery/Acceptance split inside `/kodaudit`.
- Keep the skill autonomous; do not introduce runtime dependencies on source skills.
- Use progressive disclosure: compact `SKILL.md`, conditional detail in `references/`.
- Run `python skills/kodmaster/scripts/validate_skill.py` before release.
- Do not commit secrets, generated release ZIPs or local marketplace state.
