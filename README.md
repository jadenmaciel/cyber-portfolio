# Windows Server 2025 Virtual Installation Project

## Title & Outcome

Provisioned and validated two isolated Windows Server 2025 virtual machines (Desktop Experience and Core editions) on VirtualBox 7.0.20, demonstrating full OS deployment, credential setup, and Guest Additions installation.

---

## Problem / Objectives

Establish a repeatable workflow for cleanly installing and configuring both GUI-based and headless Windows Server 2025 environments.  

Key objectives:

- Deploy standardized evaluation VMs for future domain, WSUS, and hardening projects.  

- Validate VirtualBox hardware configuration and Guest Additions integration.  

- Confirm administrator + user account provisioning consistency.

---

## Environment & Prerequisites

| Component | Details |
|------------|----------|
| Host OS | Windows 11 Pro 22H2 (x64) |
| Virtualization Platform | VirtualBox 7.0.20 + Extension Pack |
| Guest OS ISO | Windows Server 2025 Standard Evaluation (Desktop and Core) |
| Memory Allocation | 4 GB RAM per VM |
| CPU Allocation | 2 vCPUs per VM |
| Storage Allocation | 80 GB dynamic VDI |
| Credentials | `administrator / !QAZ1qaz!QAZ1qaz` ; `jmaciel / #EDC3edc#EDC3edc` |

---

## Steps Summary

1. Downloaded VirtualBox 7.0.20 and Extension Pack from official site.  

2. Created VM **Server-2025-Desktop** (4 GB RAM, 80 GB VDI, 2 vCPUs).  

3. Mounted Windows Server 2025 ISO and performed custom installation → new partition, automatic setup.  

4. Configured administrator account and signed in successfully.  

5. Created local user `jmaciel` with standardized passphrase.  

6. Installed VirtualBox Guest Additions via Devices menu → rebooted successfully.  

7. Created VM **Server-2025-Core** with same resource profile.  

8. Installed Server Core edition from same ISO and confirmed command-prompt environment.  

9. Executed `D:` → `VBoxWindowsAdditions.exe` within Core console to install Guest Additions.  

10. Ran `sconfig` to create user `jmaciel` and verified account listing.  

11. Took snapshots named "Initial Install with Tools" for both VMs.  

12. Backed up VM folders to external drive for disaster recovery.

---

## Evidence (text-only)

### Evidence 01 — VM Configuration Display

- *What would be visible:* VirtualBox main window showing VM names, base memory = 4096 MB, storage ≈ 80 GB.  

- *Text excerpt:*

  ```text

  Name: Server-2025-Desktop

  Base Memory: 4096 MB

  Storage: 80.00 GB (VDI)

  CPUs: 2

  ```

* *Why this matters:* Confirms hardware allocation meets deployment standards.

### Evidence 02 — Server Manager Launch on Desktop Edition

* *What would be visible:* Windows Server Manager dashboard displayed after first login.

* *Text excerpt:*

  ```text

  Server Manager – Dashboard

  Roles and Features Summary: No roles installed

  Computer Name: SERVER2025-DESKTOP

  ```

* *Why this matters:* Shows successful GUI installation and network initialization.

### Evidence 03 — User Accounts Panel

* *What would be visible:* Control Panel → User Accounts listing `Administrator` and `jmaciel`.

* *Text excerpt:*

  ```text

  Administrator (Local Account)

  jmaciel (Local Account)

  ```

* *Why this matters:* Proves local user creation without Microsoft sign-in.

### Evidence 04 — Guest Additions Installer Launch

* *What would be visible:* "Oracle VM VirtualBox Guest Additions Setup" wizard window.

* *Text excerpt:*

  ```text

  Oracle VM VirtualBox Guest Additions Setup Wizard

  Version 7.0.20

  ```

* *Why this matters:* Confirms driver integration to enable seamless mouse, display, and clipboard support.

### Evidence 05 — Windows Server Core Console

* *What would be visible:* Black command prompt window post-installation.

* *Text excerpt:*

  ```text

  Microsoft Windows [Version 10.0.26100]

  (c) Microsoft Corporation. All rights reserved.

  C:\Windows\System32>

  ```

* *Why this matters:* Confirms minimal headless environment running properly.

### Evidence 06 — Guest Additions Install in Core

* *What would be visible:* Command prompt running installer from `D:` drive.

* *Text excerpt:*

  ```text

  D:\>VBoxWindowsAdditions.exe

  Installing VirtualBox Guest Additions 7.0.20…

  ```

* *Why this matters:* Shows integration of Guest Additions via CLI without GUI.

### Evidence 07 — `sconfig` User Creation

* *What would be visible:* sconfig menu confirming new local user.

* *Text excerpt:*

  ```text

  Enter username: jmaciel

  The command completed successfully.

  ```

* *Why this matters:* Demonstrates account management through Server Core utilities.

---

## Results & Validation

* Both VMs boot to expected interfaces (GUI and CLI).

* `administrator` and `jmaciel` accounts authenticated successfully.

* Guest Additions enabled shared clipboard and display resizing.

* Snapshots and backups created to ensure revertible states.

---

## Timeline / Activity Dates

* **2025-09-07** — VirtualBox 7.0.20 installed and tested

* **2025-09-07** — Windows Server 2025 Desktop installation completed

* **2025-09-07** — Local user `jmaciel` created and verified

* **2025-09-07** — Guest Additions installed on Desktop and Core VMs

* **2025-09-07** — Snapshots and VM backups finalized

---

## What I Learned

* Practiced creating virtual hardware profiles matching enterprise server requirements.

* Gained experience installing Server Core and navigating text-based management (`sconfig`).

* Reinforced understanding of credential policies and secure password standards.

* Verified Guest Additions functionality for system integration testing.

* Built foundational images for subsequent domain and update deployment projects.

---

## Troubleshooting Notes

* **Guest Additions Installer not auto-launching:** Manually mounted CD and ran `VBoxWindowsAdditions.exe`.

* **CTRL+ALT+DEL passthrough:** Used VirtualBox menu Input → Keyboard → Insert Ctrl+Alt+Del.

* **Account creation blocked by network login prompt:** Temporarily disconnected network adapter to force local user setup.

* **USB backup transfer error:** Reformatted drive to NTFS to support files > 4 GB.

---

## Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** on **2025-09-07**.

It covers the installation and initial configuration of both Windows Server 2025 Desktop and Core editions in VirtualBox 7.0.20, with verified evidence of user creation, Guest Additions integration, and snapshot management.

This repository is intended for professional portfolio demonstration.
