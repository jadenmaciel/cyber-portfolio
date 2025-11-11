# SOHO Development Network — Design & Configuration (Text-Only Evidence)



## 1) Title & one-line outcome

Secure, multi-platform SOHO network designed and configured to support Windows, Linux, and macOS development workflows with WPA3 Wi-Fi, DHCP+static reservations, and selective inbound services (SSH 22, Dev 3000, HTTPS 443).



---



## 2) Problem / objectives

- Consolidate heterogeneous dev environments (Windows/macOS/Linux, mobile/tablet) under one secure SOHO design.

- Enable daily development (Docker, Node.js, Xcode, Visual Studio, VS Code Server) with reliable LAN/WLAN and ISP access.

- Enforce practical security: WPA3, hidden SSID, MAC filtering, default-deny inbound, and explicit port-forward exceptions.

- Provide clear inventory, topology, addressing plan, and router/firewall/NAT settings for reproducibility.



---



## 3) Environment & prerequisites

### 3.1) Hardware Infrastructure

- **ISP Modem:** ARRIS **SURFboard S33 DOCSIS 3.1** (up to 3.5 Gbps).

- **Router/AP:** **NETGEAR Orbi Pro WiFi 6 Mini AX1800 (SXK30)**; firmware `V1.0.9.90`. WPA3, hidden SSID, MAC filtering. DHCP + NAT + port forwards.

- **Switching:** **NETGEAR 8-Port PoE+ Unmanaged (GS308PP)** ×2, 83 W PoE budget each.

- **Cabling/Wireless:** 
  - Cat6a Ethernet for all wired connections
  - 802.11ax WiFi 6 with dual-band for wireless (M1, M2)
  - DHCP and DNS services managed via router

### 3.2) Network Configuration & Security Parameters

```text
┌─────────────────────────────────────────────────────────────────┐
│ NETGEAR Orbi Pro WiFi 6 Mini (SXK30) Configuration             │
├─────────────────────────────────────────────────────────────────┤
│ SSID                            │ Hidden                        │
│ Encryption                      │ WPA3                          │
│ MAC Filtering                   │ Enabled                       │
│ Firmware Version                │ V1.0.9.90                     │
│ DHCP Range                      │ 192.168.10.10 – 192.168.10.200│
│ Static IP (Printer B4)          │ 192.168.10.100                │
│ Static IP (Linux B1)            │ 192.168.10.201                │
│ Firewall Default Policy         │ Block all inbound             │
│ Firewall Allowed (Port Forward) │ TCP 22 (SSH → Linux B1)      │
│                                 │ TCP 443 (HTTPS → Mac Studio)  │
│                                 │ TCP 3000 (Dev Server)         │
│ ICMP (ping from WAN)            │ Blocked                       │
│ NAT                             │ Enabled (default, dynamic)    │
│ LAN Subnet                      │ 192.168.10.0/24               │
└─────────────────────────────────────────────────────────────────┘
```

**NAT (Network Address Translation) Description:**

Enabled by default on the Orbi Pro WiFi 6 Mini router. Conducts dynamic NAT to enable internal private IP addresses (192.168.10.0/24) to access external public networks through the ISP. NAT allows hiding of internal IPs and is a fundamental part of outbound traffic direction and security.

### 3.3) Switch Configuration

- **Model:** NETGEAR 8-Port PoE+ Unmanaged Switch (GS308PP)
- **Quantity:** 2 units
- **Port Configuration:** Auto-negotiated 1 Gbps (all ports)
- **PoE Budget:** 83 W per unit (166 W total)
- **Energy Efficiency:** Enabled
- **Management:** Unmanaged (plug-and-play)

### 3.4) Host Devices

- **Windows:** 11 Pro/64-bit on Dell OptiPlex 7010 Micro (A1), Alienware Aurora R16 (A2), Inspiron 14 (A3), XPS 13 (A4).

- **Linux:** Ubuntu **22.04 LTS** on Precision 5860 Tower (B1), static `192.168.10.201`.

- **macOS:** Sonoma (ARM64) on Mac Studio (B2) and MacBook Pro 16" (B3).

- **Peripherals/Mobile:** Brother MFC-L8900CDW (`192.168.10.100`), iPhone 16 Pro (iOS 18), iPad Pro 13" (iPadOS 18).

### 3.5) Device Legend & Network Roles

| Diagram Code | Device Name | Device Type | Network Role |
|-------------|-------------|-------------|--------------|
| **A1** | Dell OptiPlex 7010 Micro | Windows Low-End Desktop | Primary Network (A) |
| **A2** | Alienware Aurora R16 | Windows High-End Desktop | Primary Network (A) |
| **A3** | Dell Inspiron 14 | Windows Low-End Laptop | Primary Network (A) |
| **A4** | Dell XPS 13 | Windows High-End Laptop | Primary Network (A) |
| **B1** | Precision 5860 Tower Workstation | Linux Desktop | Secondary Network (B) |
| **B2** | Mac Studio (M3 Ultra) | macOS Desktop | Secondary Network (B) |
| **B3** | MacBook Pro 16" (M4 Max) | macOS Laptop | Secondary Network (B) |
| **B4** | Brother Color MFC-L8900CDW | Printer | Primary Network (A) |
| **M1** | iPhone 16 Pro 1TB Black | Smartphone | Secondary Network (B, Wi-Fi) |
| **M2** | iPad Pro 13" | Tablet | Secondary Network (B, Wi-Fi) |
| **C1** | NETGEAR 8-Port PoE+ Switch (x2) | Switch | Network Backbone |
| **C2** | Orbi Pro WiFi 6 Mini (SXK30) | Router/Wireless AP | Wireless Routing/AP |
| **C3** | SURFboard S33 DOCSIS 3.1 Cable Modem | Modem | ISP Gateway |
| **Solid Line** | Cat 6a Ethernet Cable | Cable | Wired Connection |
| **Dotted Line** | Coaxial Cable Line | Cable | ISP Connection |
| **Dashed Line** | 802.11ax WiFi | Wireless | Wireless Connection |



---



## 4) Steps summary

1. Connected ISP drop → **S33 modem** → **SXK30 router** WAN. Verified link.

2. Enabled **WPA3**, **hidden SSID**, **MAC filtering**; set strong admin creds.

3. Configured **DHCP** scope `192.168.10.10–192.168.10.200`; added **static** reservations for Linux workstation (`.201`) and printer (`.100`).

4. Left **NAT** enabled (default). Implemented default-deny inbound on router firewall.

5. Opened only required inbound services via **port forwarding**: TCP 22 (SSH to Linux), TCP 3000 (Dev), TCP 443 (Mac Studio web).

6. Deployed two **GS308PP PoE+** switches for wired fan-out; confirmed 1 Gbps auto-negotiation and energy-efficiency enabled.

7. Joined Windows/macOS/Linux/mobile clients; validated DHCP leases and reachability across LAN/WLAN.

8. Enabled host firewalls (Windows Defender, UFW, macOS firewall); enforced **SSH key auth** on Linux.

9. Documented device matrix (OS, IP mode, workloads) and backup strategy (Time Machine/rsync + cloud drives).

10. Compiled **inventory & cost summary** and high-level topology/legend.



---



## 5) Design Justification & Role Segmentation

### 5.1) Primary Network (A) — Windows Devices

**Rationale:** Windows devices (A1–A4) serve as the primary productivity and heavy development platform. These systems support:
- Enterprise-grade development tools (Visual Studio, .NET, Windows Subsystem for Linux)
- Cross-platform development with Docker Desktop
- Office productivity suites (Microsoft Office 365)
- Remote desktop and virtual machine hosting
- Windows-specific testing and deployment workflows

**Device Roles:**
- **A1 (Dell OptiPlex 7010 Micro):** Compact workstation for office productivity and light development
- **A2 (Alienware Aurora R16):** High-performance desktop for intensive development, gaming, and resource-heavy tasks
- **A3 (Inspiron 14):** Portable development laptop for on-the-go coding
- **A4 (XPS 13):** Ultra-portable laptop for client meetings and mobile development

### 5.2) Secondary Network (B) — Linux & macOS Devices

**Rationale:** Linux and macOS systems provide specialized development capabilities:
- **Linux (B1):** Containerization and backend development (Docker, Kubernetes, server-side applications)
- **macOS (B2/B3):** iOS/macOS app development (Xcode, Swift), Unix-based development environment, and creative workflows

**Device Roles:**
- **B1 (Precision 5860 Tower):** Linux workstation with static IP for reliable SSH access and server hosting
- **B2 (Mac Studio):** High-performance macOS development station for Xcode and creative applications
- **B3 (MacBook Pro 16"):** Portable macOS development laptop for iOS app development and testing

### 5.3) Network Backbone

**Rationale:** The network infrastructure ensures secure, high-speed connectivity:
- **Cabling (Cat6a):** Future-proofed gigabit Ethernet with headroom for 10 Gbps
- **Modem (S33):** DOCSIS 3.1 support for high-speed ISP connectivity (up to 3.5 Gbps)
- **Router (SXK30):** WPA3 security, advanced firewall, and port forwarding for selective service exposure
- **Switches (GS308PP):** PoE+ capability for future expansion (IP cameras, access points) with unmanaged simplicity

### 5.4) Security Architecture

**Rationale:** Multi-layered security approach:
- **WPA3 + Hidden SSID + MAC Filtering:** Prevents unauthorized wireless access
- **Default-Deny Firewall:** Only explicitly allowed services are exposed (SSH, HTTPS, Dev Server)
- **Host Firewalls:** Defense in depth with platform-specific firewall rules
- **SSH Key Authentication:** Eliminates password-based SSH attacks on Linux workstation
- **Static IP Reservations:** Predictable addressing for infrastructure services (print, SSH)

---

## 6) Evidence (text-only, replaces screenshots)

**Evidence 01 — Router wireless/security baseline**

**What would be visible:** Orbi Pro admin UI → Wireless & Security.

**Text excerpt:** `SSID: Hidden`, `Encryption: WPA3`, `MAC Address Filtering: Enabled`, `Firmware: V1.0.9.90`.

**Why this matters:** Confirms WPA3, obscured SSID, and MAC allow-list for client admission.



**Evidence 02 — Addressing & reservations**

**What would be visible:** LAN → DHCP.

**Text excerpt:** `DHCP Range: 192.168.10.10 – 192.168.10.200`, `Reserved: 192.168.10.201 (Linux B1)`, `192.168.10.100 (Printer B4)`.

**Why this matters:** Ensures predictable endpoints for SSH/web/printing while keeping dynamic leases for clients.



**Evidence 03 — Inbound access policy**

**What would be visible:** Firewall/Port Forwarding.

**Text excerpt:** `Default: Block all inbound traffic`, `Allowed: SSH (TCP 22) → Linux Workstation (SSH)`, `Dev Server (TCP 3000) → Dev Server Instance`, `HTTPS (TCP 443) → Mac Studio Web Server`.

**Why this matters:** Implements least-privilege exposure for remote dev and HTTPS services.



**Evidence 04 — NAT status**

**What would be visible:** WAN/NAT settings.

**Text excerpt:** `NAT: Enabled (dynamic)`, `LAN: 192.168.10.0/24`.

**Why this matters:** Verifies internal private addressing is translated for outbound internet access.



**Evidence 05 — Device matrix (roles & OS)**

**What would be visible:** Documentation table.

**Text excerpt:** Windows (A1–A4), Ubuntu 22.04 LTS (B1 static `.201`), macOS Sonoma (B2/B3), Printer `.100`, iOS/iPadOS 18.

**Why this matters:** Confirms heterogenous platforms and their addressing modes for dev workloads.



**Evidence 06 — Inventory & totals**

**What would be visible:** Summary spreadsheet with device catalog, unit prices, purchase sources, and category subtotals.

**Text excerpt:** `Grand Total: $24,618.28` with category subtotals (Desktops $13,652.34; Laptops $6,158.98; Networking $758.97; Mobile & Peripherals $4,047.99).

**Why this matters:** Captures scope, cost profile, and completeness of the network build.

---

### 6.1) Evidence — Inventory and Cost Summary

**Device Catalog & Inventory**

| Diagram Code | Device Name | OS / Firmware | IP Assignment | Applications / Functions | Unit Price | Total Price | Purchase Source |
|-------------|-------------|---------------|---------------|-------------------------|------------|-------------|-----------------|
| **A1** | Dell OptiPlex 7010 Micro | Windows 11 Pro (64-bit) | DHCP | MS Office, Edge, GitHub Desktop | $959.00 | $959.00 | [Source Link] |
| **A2** | Alienware Aurora R16 | Windows 11 Pro (64-bit) | DHCP | Visual Studio, Unity, Docker, Postman | $3,349.99 | $3,349.99 | [Source Link] |
| **A3** | Dell Inspiron 14 | Windows 11 Home (64-bit) | DHCP | Email, Slack, VSCode | $699.99 | $699.99 | [Source Link] |
| **A4** | Dell XPS 13 | Windows 11 Pro (64-bit) | DHCP | PyCharm, Git, VirtualBox | $1,459.99 | $1,459.99 | [Source Link] |
| **B1** | Precision 5860 Tower Workstation | Ubuntu 22.04 LTS (64-bit) | Static 192.168.10.201 | Docker, SSH, Node.js, VSCode Server | $5,344.35 | $5,344.35 | [Source Link] |
| **B2** | Mac Studio (M3 Ultra) | macOS Sonoma (ARM64) | DHCP | Xcode, Swift, Figma, Slack | $3,999.00 | $3,999.00 | [Source Link] |
| **B3** | MacBook Pro 16" (M4 Max) | macOS Sonoma (ARM64) | DHCP | Xcode, GitHub CLI, Zoom | $3,999.00 | $3,999.00 | [Source Link] |
| **B4** | Brother Color MFC-L8900CDW | Firmware vL8.00 | Static 192.168.10.100 | Printing, Scanning, Network Backup | $649.99 | $649.99 | [Source Link] |
| **C1** | NETGEAR 8-Port PoE+ Switch (x2) | Network Switch Firmware | N/A | 8-Port PoE+ Switching, 83W PoE Budget per unit | $129.99 | $259.98 | [Source Link] |
| **C2** | Orbi Pro WiFi 6 Mini (SXK30) | Router Firmware V1.0.9.90 | Router (192.168.10.1) | Wi-Fi 6 Router, WPA3, DHCP, NAT, Port Forwarding | $299.99 | $299.99 | [Source Link] |
| **C3** | SURFboard S33 DOCSIS 3.1 Cable Modem | Modem Firmware | Modem (WAN) | DOCSIS 3.1 Cable Modem, up to 3.5 Gbps | $199.00 | $199.00 | [Source Link] |
| **M1** | iPhone 16 Pro 1TB Black | iOS 18 | DHCP via Wi-Fi | Safari, Mail, TestFlight | $1,499.00 | $1,499.00 | [Source Link] |
| **M2** | iPad Pro 13" | iPadOS 18 | DHCP via Wi-Fi | Notability, Procreate, Safari | $1,899.00 | $1,899.00 | [Source Link] |

**Category Subtotals:**
- **Desktops (A1, A2, B1, B2):** $13,652.34
- **Laptops (A3, A4, B3):** $6,158.98
- **Networking Equipment (C1, C2, C3):** $758.97
- **Mobile & Peripherals (B4, M1, M2):** $4,047.99

**Grand Total: $24,618.28**

*Note: Device prices have been populated from the source documentation. 

---

## 7) Software & Services Matrix

| Device Code | Device Name | Operating System | Applications / Services | Development Tools | Security Features |
|------------|-------------|------------------|------------------------|-------------------|-------------------|
| **A1** | Dell OptiPlex 7010 Micro | Windows 11 Pro (64-bit) | MS Office, Edge, GitHub Desktop | GitHub Desktop, Edge | Windows Defender, Local Firewall |
| **A2** | Alienware Aurora R16 | Windows 11 Pro (64-bit) | Visual Studio, Unity, Docker, Postman | Visual Studio, Unity, Docker, Postman | Windows Defender, Local Firewall |
| **A3** | Dell Inspiron 14 | Windows 11 Home (64-bit) | Email, Slack, VSCode | VSCode, Slack | Windows Defender, Local Firewall |
| **A4** | Dell XPS 13 | Windows 11 Pro (64-bit) | PyCharm, Git, VirtualBox | PyCharm, Git, VirtualBox | Windows Defender, Local Firewall |
| **B1** | Precision 5860 Tower Workstation | Ubuntu 22.04 LTS (64-bit) | Docker, SSH, Node.js, VSCode Server | Docker, Node.js, VSCode Server, Git | UFW Firewall, SSH Key Auth, Fail2ban |
| **B2** | Mac Studio (M3 Ultra) | macOS Sonoma (ARM64) | Xcode, Swift, Figma, Slack | Xcode, Swift, Figma, Slack | macOS Firewall, SSH Key Auth |
| **B3** | MacBook Pro 16" (M4 Max) | macOS Sonoma (ARM64) | Xcode, GitHub CLI, Zoom | Xcode, GitHub CLI, Zoom | macOS Firewall, SSH Key Auth |
| **B4** | Brother Color MFC-L8900CDW | Firmware vL8.00 | Printing, Scanning, Network Backup | N/A | Network Access Control, Static IP |
| **M1** | iPhone 16 Pro 1TB Black | iOS 18 | Safari, Mail, TestFlight | TestFlight, Safari | Remote Wipe, Passcode, Biometric Auth |
| **M2** | iPad Pro 13" | iPadOS 18 | Notability, Procreate, Safari | Notability, Procreate, Safari | Remote Wipe, Passcode, Biometric Auth |

**Cross-Platform Development Stack:**
- **Containerization:** Docker Desktop (Windows/macOS), Docker Engine (Linux)
- **Version Control:** Git (all platforms), GitHub/GitLab integration
- **Code Editors:** VS Code (cross-platform), Visual Studio (Windows), Xcode (macOS)
- **Runtime Environments:** Node.js, Python, .NET SDK, Swift
- **Remote Access:** SSH (Linux), Remote Desktop (Windows), Screen Sharing (macOS)

---

## 8) Security & Backup Practices

### 8.1) Global Security Features

**Router/Firewall Security:**
- WPA3 encryption with hidden SSID
- MAC address filtering (whitelist-only)
- Default-deny inbound firewall policy
- Explicit port forwarding rules (TCP 22, 443, 3000 only)
- ICMP (ping) blocked from WAN
- NAT enabled for outbound traffic translation
- Strong administrator credentials (unique, complex passwords)

**Host-Level Security:**
- **Windows Devices (A1–A4):** Local firewall enabled (Windows Defender), automatic updates
- **Linux Device (B1):** Local firewall enabled (UFW), SSH key authentication, Fail2ban for intrusion prevention, automatic security updates
- **macOS Devices (B2–B3):** Local firewall enabled (macOS firewall), SSH key authentication, Gatekeeper for app security, automatic updates
- **Mobile Devices (M1–M2):** Remote wipe enabled on M1 and M2, passcode/biometric authentication, encrypted backups, Find My iPhone/iPad
- **Network Printer (B4):** Static IP reservation, network access control, firmware updates

**Authentication & Access Control:**
- Unique login passwords for each device
- SSH key authentication for Linux (B1)
- Two-factor authentication where supported (cloud services, GitHub, etc.)
- Regular credential rotation schedule
- Admin account separation (non-admin daily use accounts)

**Network Segmentation:**
- Single subnet (192.168.10.0/24) with logical separation via static reservations
- Infrastructure devices (printer, Linux workstation) on static IPs outside DHCP pool
- All unused ports closed via router/firewall
- Port forwarding limited to essential services only

### 8.2) Backup Strategy

- Daily backups to Google Drive, iCloud, OneDrive
- Development files version-controlled (GitHub/GitLab)
- macOS/Linux backups with Time Machine or rsync



---



## 9) Results & validation

- All wired ports negotiated at **1 Gbps**; Wi-Fi 6 clients associated successfully under WPA3.

- Clients obtained leases in `192.168.10.0/24`; static endpoints (`.201`, `.100`) were consistently reachable.

- External requests to TCP **22/3000/443** reached the intended hosts (functional port forwarding); all other inbound traffic was dropped by default policy.



---



## 10) Timeline / Activity Dates

- **2025-11** — Network design, inventory, addressing plan, and router configuration documented and validated from the source file. *(Month/year inferred from context.)*



---



## 11) What I Learned

### 11.1) Network Design & Architecture

- Designing a mixed-OS developer network with **least-privilege exposure** can remain simple (single subnet + selective forwards).
- WPA3 + hidden SSID + MAC filtering raises the bar for casual abuse without adding major operational friction.
- Static reservations for infrastructure (workstation/print) simplify remote dev, backups, and service mapping.
- Documenting **firmware, scopes, and forwards** is essential for reproducibility and audits.
- Keeping switches **unmanaged but PoE-capable** is a pragmatic choice for a small shop with room to grow.

### 11.2) Cross-Platform Development

- **Containerization (Docker):** Enables consistent development environments across Windows, Linux, and macOS, reducing platform-specific issues.
- **Version Control (Git):** Centralized code repositories allow seamless collaboration across different operating systems and devices.
- **Remote Development:** VS Code Server and SSH enable development on Linux workstations from any platform, maximizing resource utilization.
- **Platform-Specific Tools:** Understanding when to use Xcode (macOS/iOS) vs. Visual Studio (Windows) vs. native Linux tools is crucial for efficient workflows.

### 11.3) Security Hardening

- **Defense in Depth:** Multiple security layers (router firewall, host firewalls, SSH keys) provide redundancy against attacks.
- **Least Privilege:** Only exposing necessary services (SSH, HTTPS, Dev Server) minimizes attack surface.
- **Authentication Best Practices:** SSH key authentication eliminates password-based attacks; unique passwords prevent credential stuffing.
- **Network Segmentation:** Static IP reservations and logical separation simplify security policy enforcement.

### 11.4) DHCP Management

- **DHCP Pool Design:** Keeping static reservations outside the DHCP pool (`.201`, `.100` outside `.10–.200`) prevents IP conflicts.
- **Predictable Addressing:** Static IPs for infrastructure devices (printer, SSH server) enable reliable service discovery and port forwarding.
- **Lease Management:** Understanding DHCP lease times and renewal processes helps troubleshoot connectivity issues.

### 11.5) Port Forwarding & NAT

- **Selective Exposure:** Only forwarding essential ports (22, 443, 3000) balances accessibility with security.
- **Host Firewall Coordination:** Port forwarding requires corresponding host firewall rules to allow traffic to reach services.
- **NAT Translation:** Understanding how NAT maps external ports to internal IPs is critical for service accessibility.

### 11.6) Documentation Skills

- **Text-Only Evidence:** Converting screenshots to textual descriptions ensures documentation remains accessible and version-controlled.
- **Comprehensive Inventory:** Detailed device catalogs with prices, purchase sources, and configurations enable cost tracking and replacement planning.
- **Troubleshooting Documentation:** Recording common issues and solutions accelerates future problem resolution.
- **Reproducibility:** Clear configuration documentation allows network rebuilds and audits without guesswork.



---



## 12) Troubleshooting notes

- **Cannot join Wi-Fi:** verify device MAC is on the allow-list; confirm WPA3 support or enable transitional mode if required.

- **Port forward fails:** ensure host firewall allows the service and the reservation/IP is correct.

- **DHCP conflicts:** confirm static addresses lie **outside** the DHCP pool (`.10–.200`).

- **Printing unavailable:** confirm printer static IP `192.168.10.100` and that clients resolve it; re-add via IP if needed.

- **SSH issues:** require key-based auth on B1 and confirm TCP 22 is forwarded only to B1.



---



## 13) Author / ownership

This project was performed hands-on by **Jaden Maciel-Shapiro**. Timeline reference: **2025-11** (design and documentation per source). Focus areas: secure SOHO topology, addressing/NAT, selective inbound exposure for development services, and multi-OS workload enablement. This repository is for professional portfolio use.
