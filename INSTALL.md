# Installation

## Codex on Windows — easiest way

1. Download `kodmaster-v4-codex-windows.zip` from the latest GitHub Release.
2. Right-click the ZIP → **Extract All**.
3. Open the extracted folder.
4. Double-click `install-kodmaster.cmd`.
5. Wait for `INSTALLATION COMPLETE`.
6. Start a new Codex task. If KodMaster is not visible, restart Codex once.

The installer places one copy at `%USERPROFILE%\.agents\skills\kodmaster`, the official user-wide skill location. It validates the package before replacing an existing installation and rolls back if copying fails.

### Update

Repeat the same six steps with a newer ZIP.

### Uninstall

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-kodmaster.ps1 -Uninstall
```

The script shows the exact target and asks for confirmation unless `-Force` is supplied.

## Codex on macOS/Linux

Copy `skills/kodmaster` to `$HOME/.agents/skills/kodmaster`, then start a new task.

## ChatGPT web

1. Download `kodmaster-v4-skill.zip`.
2. Open ChatGPT in the browser.
3. Open **Plugins → Skills → Create → Upload from computer**.
4. Select the ZIP and finish the upload.
5. In a new chat, select the skill or write a matching request such as “Use KodMaster to audit my whole application.”

ChatGPT web and local Codex use separate installations. Availability can depend on your ChatGPT plan/workspace settings.

## Verify

Ask:

```text
Use KodMaster and show /kodhelp.
```

You should see `KodMaster v4 active` and the `/kodaudit`/`/uiaudit` commands.

## Manual validation for developers

```powershell
python .\skills\kodmaster\scripts\validate_skill.py
```
