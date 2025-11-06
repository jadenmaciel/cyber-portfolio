# Windows File Server Role Configuration (Server 2025)

### Outcome  

Deployed and validated a multi-group file-sharing architecture on Windows Server 2025 Core with domain-based SMB and NFS shares accessible from Windows and Ubuntu clients.

---

## Problem / Objectives

Implement a secure, role-based file server that:

* Supports multiple department groups (Web Developers, HR, Accounting, Engineering, Sales).  

* Enforces least-privilege access and hides unauthorized shares.  

* Enables both SMB and NFS interoperability for Windows and Linux clients.  

* Validates share permissions, mappings, and access controls.

---

## Environment & Prerequisites

* **Host OS:** Windows 11 Pro  

* **Virtualization:** Oracle VirtualBox 7.x + Extension Pack  

* **Server OS:** Windows Server 2025 Core (AD-joined)  

* **Client VMs:** Windows 11 Enterprise (domain joined) + Ubuntu 24.04 LTS  

* **Network:** Internal Network mode  

* **Tools:** Server Manager, PowerShell 7.x, Ubuntu terminal (Bash)  

---

## Steps Summary

1. Created five Active Directory security groups: `Web Developers`, `Human Resources`, `Accounting`, `Engineering`, `Sales`.  

2. Added ten user accounts (`firstname.lastname` pattern) with standardized password `#EDC3edc#EDC3edc`.  

3. Installed **File Server** role on Server 2025 Core.  

4. Created SMB share `Webroot` at `C:\inetpub\wwwroot\mynewsite` for Web Developers (full control, access-based enumeration enabled).  

5. Mapped `\\SERVERCORE\Webroot` to `Z:\` on Windows client and verified write access.  

6. Created and linked new HTML file within mapped share to validate web update via domain URL.  

7. Created restricted `Accounting` share with permissions only for Accounting group (full control) and revoked all others.  

8. Tested visibility and access from Accounting vs non-Accounting users (`whoami /fqdn`).  

9. Created read-only `Corporate` share accessible to all five groups (read permissions only).  

10. Installed **NFS share role** and mounted `Unix Clients` share from Ubuntu VM via CIFS.  

---

## Evidence (text-only)

**Evidence 01 — Group and User Setup**  

*What would be visible:* Active Directory Users and Computers showing five security groups each with two members.  

*Text excerpt:*  

```text

Group: Web Developers – Members: jaden.maciel-shapiro, alex.smith

Group: Accounting – Members: emma.jones, li.chen

```

*Why this matters:* Confirms group-based RBAC structure for share assignment.

---

**Evidence 02 — Share Creation (Webroot)**

*What would be visible:* Server Manager → File and Storage Services → Shares pane listing `Webroot`.

*Text excerpt:*

```text

Share Name: Webroot

Local Path: C:\inetpub\wwwroot\mynewsite

Access-Based Enumeration: Enabled

Group: Web Developers – Full Control

```

*Why this matters:* Validates correct share creation and permissions for Web Developers.

---

**Evidence 03 — Mapped Drive Validation**

*What would be visible:* File Explorer left pane showing `Z:\ (Webroot)` mapped to Server Core.

*Text excerpt:*

```text

Z:\ Webroot (\\SERVERCORE\Webroot)

iisstart.html  iisstart.png  index.html

```

*Why this matters:* Confirms SMB share mapping and read/write access from Windows client.

---

**Evidence 04 — Accounting Share Permissions**

*What would be visible:* Share permissions screen listing only Accounting group with Full Control.

*Text excerpt:*

```text

Accounting – Full Control

SYSTEM – Full Control

Administrators – Full Control

```

*Why this matters:* Verifies least-privilege access for sensitive department data.

---

**Evidence 05 — Access Restriction Validation**

*What would be visible:* Non-Accounting user attempting to view Accounting share in Network browser.

*Text excerpt:*

```text

Network Path not found.

whoami /fqdn → salesuser1.corp.local

```

*Why this matters:* Confirms access-based enumeration and permission enforcement.

---

**Evidence 06 — Corporate Read-Only Share**

*What would be visible:* Advanced Security Settings showing five groups with Read permissions only.

*Text excerpt:*

```text

Web Developers – Read

Human Resources – Read

Accounting – Read

Engineering – Read

Sales – Read

```

*Why this matters:* Demonstrates domain-wide read-only access configuration.

---

**Evidence 07 — NFS Mount on Ubuntu**

*What would be visible:* Terminal output from Ubuntu after mounting `Unix Clients` share.

*Text excerpt:*

```bash

$ sudo mount -t cifs //192.168.56.10/Unix Clients /mnt/unixshare -o username=jaden.maciel-shapiro,password=#EDC3edc#EDC3edc

$ df -h

//192.168.56.10/Unix Clients   50G  5G  45G  10% /mnt/unixshare

$ touch /mnt/unixshare/testfile.txt

```

*Why this matters:* Proves cross-platform read/write access via CIFS/NFS mount.

---

## Results & Validation

* All departmental shares enforced expected access rights.

* Access-based enumeration hid unauthorized folders.

* Read-only shares blocked write attempts.

* Ubuntu VM successfully mounted and wrote to NFS share.

---

## Timeline / Activity Dates

* 2025-09-28 — Project executed and verified (File Server Role deployment).

---

## What I Learned

* Implemented Windows Server File and Storage Services roles.

* Configured Active Directory groups and permission-based shares.

* Practiced least-privilege design and access-based enumeration.

* Integrated Linux client via CIFS/NFS for interoperable sharing.

* Validated permissions through command-line and GUI tests.

---

## Troubleshooting Notes

* Resolved client join issues by re-enabling network discovery and domain firewall rules.

* Used `Disable Inheritance` to remove default BUILTIN\Users permissions.

* Fixed mount errors on Ubuntu by installing `cifs-utils` and reconnecting to internal network.

* Ensured shares accessible after reboots via persistent mapping flags.

---

## Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** on **September 28, 2025** as part of professional portfolio development in system administration and access-control validation.

All configurations, tests, and evidence were personally executed in VirtualBox lab VMs for Windows Server 2025 and Ubuntu 24.04.
