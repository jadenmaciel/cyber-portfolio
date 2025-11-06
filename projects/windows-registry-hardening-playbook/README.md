# Windows Registry Hardening Playbook

A concise, reproducible set of Windows registry edits to improve usability and harden endpoints—implemented and validated on a disposable VM with before/after evidence.

---

## Objectives

- Add productivity tweaks (e.g., open Notepad from desktop right-click).

- Reduce noise (remove *3D Objects* from "This PC", disable Bing-in-Start).

- Streamline login (skip the Lock screen).

- Limit attack surface (disable USB storage class).

- Expose system/version info on the desktop for quick triage.

- Centralize evidence of each change.

---

## Environment & Prereqs

- **OS:** Windows 10/11 (x64), Pro or Home

- **Access:** Local admin

- **Tools:** `regedit.exe` (built-in), optional VM snapshot/restore

- **Safety:** Work on a **VM copy** or create a restore point/snapshot first

---

## Steps Summary (6–12 crisp bullets)

1. **Add "Notepad" to Desktop right-click**

   Path: `HKEY_CLASSES_ROOT\directory\background\Shell` → **New > Key** `Notepad` → under it **New > Key** `command` → set `(Default)` to `notepad.exe`.

   _Expected evidence:_ `01-notepad-context-menu.png`



2. **Show seconds in the taskbar clock**

   Path: `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced` → **New > DWORD (32-bit)** `ShowSecondsInSystemClock` = `1` → **sign out/in or restart Explorer**.

   _Expected evidence:_ `02-clock-seconds.png`



3. **Remove "3D Objects" from "This PC"**

   Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace` → delete the key starting with `{0DB7E03F...513A}`.

   _Expected evidence:_ `03-remove-3d-objects.png`



4. **Skip the Lock screen**

   Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows` → **New > Key** `Personalization` → **New > DWORD** `NoLockScreen` = `1` → **restart**.

   _Expected evidence:_ `04-disable-lock-screen.png`



5. **Disable Bing in Start**

   Path: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search` → **New > DWORD** `BingSearchEnabled` = `0`.

   _Expected evidence:_ `05-disable-bing.png`



6. **Disable Cortana**

   Path: `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows` → **New > Key** `Windows Search` → **New > DWORD** `AllowCortana` = `0` → **restart**.

   _Expected evidence:_ `06-disable-cortana.png`



7. **Disable USB storage class (front USB ports)**

   Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\USBSTOR` → set `Start` from `3` to `4` → **restart**. (Re-enable by setting back to `3`.)

   _Expected evidence:_ `07-disable-usbstor.png`



8. **"Run as Administrator" on EXE right-click**

   Path: `HKEY_CLASSES_ROOT\exefile\shell` → **New > Key** `runas` → set `(Default)` = `Run as Administrator` → **New > Key** `command` under `runas` → set `(Default)` = `"%1" %*`.

   _Expected evidence:_ `08-run-as-admin-context.png`



9. **Show Windows version overlay on the desktop**

   Path: `HKEY_CURRENT_USER\Control Panel\Desktop` → set or create **DWORD** `PaintDesktopVersion` = `1` → **sign out/in**.

   _Expected evidence:_ `09-desktop-version-overlay.png`



10. **(Alt path) Show seconds—Explorer restart only**

    Same value as Step 2; after setting, **restart Windows Explorer** in Task Manager.

    _Expected evidence:_ `10-hkcu-showseconds.png`



> Tip: For each step, capture a before/after screenshot and save into `/artifacts/` using the names below.

---

## Evidence & Artifacts

Place screenshots and any exported `.reg` snippets here:



- `artifacts/01-notepad-context-menu.png`

- `artifacts/02-clock-seconds.png`

- `artifacts/03-remove-3d-objects.png`

- `artifacts/04-disable-lock-screen.png`

- `artifacts/06-disable-cortana.png`

- `artifacts/07-disable-usbstor.png`

- `artifacts/08-run-as-admin-context.png`

- `artifacts/09-desktop-version-overlay.png`

- `artifacts/10-hkcu-showseconds.png`

---

## Results & Validation

- Right-click **Desktop** shows **Notepad** entry and launches `notepad.exe`.

- Taskbar clock displays **HH:MM:SS**.

- "This PC" **no longer lists _3D Objects_**.

- Boot/login flow **skips Lock screen**.

- Start menu **does not query Bing**; searches are local.

- **Cortana disabled** (no assistant UI; policies respected).

- Inserting a USB mass-storage device **does not auto-mount** (USBSTOR disabled).

- Right-clicking an `.exe` shows **Run as Administrator** entry.

- Desktop shows **build/version overlay** in lower-right corner.

---

## What I Learned

- Precise registry navigation and key/value authoring for user and machine scopes.

- Practical endpoint hardening: disabling unneeded integrations (Bing/Cortana/USBSTOR).

- Usability boosts via context menu and shell namespace cleanup.

- Change control discipline: before/after evidence, revert paths, and safe-testing on VMs.

---

## Troubleshooting Notes

- **Admin rights required:** Run `regedit.exe` as admin for HKLM and policy paths.

- **Restart needed:** Some values require **sign out/in** or a **reboot** (Lock screen, Cortana).

- **Explorer cache:** After UI tweaks, restart **Windows Explorer** from Task Manager (`End task` → `File > Run new task > explorer.exe`).

- **Wrong hive:** If a setting "does nothing," confirm you're editing **HKCU vs. HKLM** as specified.

- **USBSTOR effect:** Disabling `USBSTOR` blocks new mass-storage mounts; existing installed drivers may still show cached devices until reboot.

- **Revert strategy:** Document original values; keep exported `.reg` backups before deletions (right-click key → **Export**).

---
