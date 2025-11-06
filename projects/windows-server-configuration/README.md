# Windows Server 2025 Configuration — GUI and Core Setup

## 1. Title & One-Line Outcome

Configured Windows Server 2025 in both **Desktop Experience** (Server Manager) and **Server Core** (Server Configuration) modes to establish hostname, domain membership, Remote Desktop, static IP, updates, and timezone synchronization.

---

## 2. Problem / Objectives

Demonstrate initial configuration of a Windows Server 2025 environment using two administrative interfaces:

- **Server Manager:** graphical configuration for basic setup.

- **Server Configuration (sconfig):** command-line configuration for Server Core edition.

The goal was to achieve identical baseline states across both editions.

---

## 3. Environment & Prerequisites

- **Host:** Windows 11 Pro (64-bit) with Oracle VirtualBox 7.x

- **Guest VMs:** Windows Server 2025 Standard — Desktop Experience & Server Core

- **Network:** Internal Network (192.168.0.0/24)

- **Tools:** Server Manager, Server Configuration (`sconfig`), PowerShell 7.x, WinGet

- **Date Performed:** 2025-09-14

- **Author:** Jaden Maciel-Shapiro

---

## 4. Steps Summary

1. **Renamed** server to `WinSrvjmaciel-DC1`.

2. **Joined** server to organizational domain `CY2650jmaciel.local`.

3. **Enabled** Remote Desktop and added domain user.

4. **Assigned** static IP `192.168.0.100/24` with gateway `192.168.0.100`.

5. **Verified** Windows Update and installed available patches.

6. **Disabled** IE Enhanced Security Configuration for administrators.

7. **Adjusted** system time zone (Pacific Time).

8. **Configured Server Core** hostname `WinSrvjmaciel-Core`.

9. **Joined Server Core** to domain and enabled Remote Desktop.

10. **Configured Server Core** static IP `192.168.0.101`.

11. **Ran updates** via `sconfig` option 5.

12. **Validated** correct date/time settings.

13. **Created** snapshots and backups for VM preservation.

---

## 5. Evidence (Text-Only)

### Evidence 01 — Server Rename

*What would be visible:* System Properties → Computer Name field showing `WinSrvjmaciel-DC1`.

*Text excerpt:*

```text

Computer Name: WinSrvjmaciel-DC1

Domain: Workgroup

```

*Why this matters:* Confirms rename succeeded prior to domain join.

### Evidence 02 — Domain Join

*What would be visible:* System Properties showing domain `CY2650jmaciel.local`.

*Text excerpt:*

```text

Domain: CY2650jmaciel.local

Welcome to the domain CY2650jmaciel.local!

```

*Why this matters:* Indicates successful AD integration.

### Evidence 03 — Remote Desktop Users

*What would be visible:* Remote Desktop Users dialog listing `jmaciel`.

*Text excerpt:*

```text

Remote Desktop Users:

  jmaciel (CY2650JMACIEL\jmaciel)

```

*Why this matters:* Verifies remote administrative access enabled.

### Evidence 04 — Static IP Configuration

*What would be visible:* IPv4 properties window.

*Text excerpt:*

```text

IP Address: 192.168.0.100

Subnet Mask: 255.255.255.0

Default Gateway: 192.168.0.100

Preferred DNS: 192.168.0.100

```

*Why this matters:* Shows persistent network assignment for domain role.

### Evidence 05 — Update Verification

*What would be visible:* Windows Update status panel.

*Text excerpt:*

```text

Last checked for updates: 09/14/2025 08:42 AM

Your device is up to date.

```

*Why this matters:* Confirms system patched and secure.

### Evidence 06 — Server Core Configuration

*What would be visible:* `sconfig` menu output.

*Text excerpt:*

```text

Server name: WinSrvjmaciel-Core

Domain: CY2650jmaciel.local

Remote Desktop: Enabled (Secure Mode)

IPv4 Address: 192.168.0.101

DNS Servers: 192.168.0.100

```

*Why this matters:* Proves Core server mirrors GUI configuration.

---

## 6. Results & Validation

* Both servers configured successfully with unique static IPs.

* Domain membership confirmed via System Properties and `sconfig`.

* Remote Desktop verified accessible.

* Windows Update completed with latest patch levels.

* Time zone alignment ensured consistent logging and sync.

---

## 7. Timeline / Activity Dates

* **2025-09-14 — Renamed servers, joined domain, configured network and updates.**

* **2025-09-14 — Validated Remote Desktop, disabled IE ESC, adjusted time zone.**

---

## 8. What I Learned

* Configured Windows Server 2025 both graphically and via command-line.

* Used `sconfig` automation options for Core management.

* Understood domain join dependencies and IP/DNS relationships.

* Managed updates using WinGet and PowerShell modules.

* Practiced snapshot and backup strategies for VM integrity.

---

## 9. Troubleshooting Notes

* Required elevated permissions for domain join and Remote Desktop.

* Resolved VirtualBox network adapter naming issues.

* Verified DNS connectivity before domain join.

* Adjusted firewall for RDP access.

---

## 10. Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** on 2025-09-14.

The work focused on Windows Server 2025 hardening and configuration validation.

This repository serves as a professional portfolio artifact demonstrating system administration competence.

---
