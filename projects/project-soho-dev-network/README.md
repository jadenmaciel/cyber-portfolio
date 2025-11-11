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

- **ISP Modem:** ARRIS SURFboard S33 DOCSIS 3.1 (up to 3.5 Gbps)

- **Router/AP:** NETGEAR Orbi Pro WiFi 6 Mini AX1800 (SXK30); firmware `V1.0.9.90`

- **Switching:** NETGEAR 8-Port PoE+ Unmanaged (GS308PP) ×2, 83 W PoE budget each

- **Cabling/Wireless:** Cat6a; 802.11ax (Wi-Fi 6)

- **Hosts (examples):** Windows 11 Pro (A1/A2/A4), Ubuntu 22.04 LTS (B1 static `192.168.10.201`), macOS Sonoma (B2/B3), Printer `192.168.10.100`, iOS/iPadOS 18

---

## 4) Steps summary

1. Modem (S33) → Router (SXK30) WAN

2. Enable WPA3, hidden SSID, MAC filtering; rotate admin creds

3. DHCP scope `192.168.10.10–192.168.10.200`; reservations: printer `.100`, Linux `.201`

4. Keep NAT default; default-deny inbound

5. Port forwards: TCP 22 (Linux), 3000 (Dev), 443 (Mac Studio)

6. Deploy two GS308PP PoE+ switches (1GbE auto-negotiation)

7. Join clients; validate leases and reachability

8. Host firewalls enabled; SSH key auth on Linux

9. Document device matrix, costs, and topology

---

## 5) Evidence (text-only, replaces screenshots)

**Evidence 01 — Router wireless/security**

- What would be visible: Orbi Pro → Wireless & Security

- Text excerpt: `SSID: Hidden`, `WPA3`, `MAC Filtering: Enabled`, `Firmware: V1.0.9.90`

- Why this matters: Validates secure Wi-Fi baseline

**Evidence 02 — DHCP & reservations**

- What would be visible: LAN → DHCP

- Text excerpt: `Range: 192.168.10.10–192.168.10.200`, `Reserved: .201 (Linux), .100 (Printer)`

- Why this matters: Predictable addressing for services

**Evidence 03 — Inbound policy / forwards**

- What would be visible: Firewall/Port Forward

- Text excerpt: `Default: Block all inbound`, `Allow: 22→Linux, 3000→Dev, 443→Mac`

- Why this matters: Least-privilege exposure

**Evidence 04 — NAT status**

- What would be visible: WAN/NAT

- Text excerpt: `NAT: Enabled (dynamic)`, `LAN: 192.168.10.0/24`

- Why this matters: Confirms outbound translation

**Evidence 05 — Inventory & totals**

- What would be visible: Summary sheet

- Text excerpt: Grand Total `$24,618.28` (Desktops $13,652.34; Laptops $6,158.98; Networking $758.97; Mobile & Peripherals $4,047.99)

- Why this matters: Cost/scale verification

---

## 6) Results & validation

- 1GbE negotiated on wired; Wi-Fi 6 clients associate under WPA3

- Static endpoints reachable; forwards deliver to intended hosts

- All other inbound traffic is blocked by default

---

## 7) Timeline / Activity Dates

- 2025-11 — Design and configuration documented

---

## 8) What I Learned

- Practical least-privilege networking with simple topology

- WPA3 + SSID hiding + MAC filtering tradeoffs

- DHCP planning + reservations for service stability

- Documenting firmware, scopes, and forwards aids repeatability

---

## 9) Troubleshooting notes

- Wi-Fi join issues: MAC allow-list and WPA3 support

- Forwarding failures: host firewall + reservation IPs

- DHCP conflicts: keep statics outside pool

- SSH: enforce key-based auth and correct single target

---

## 10) Author / ownership

This project was performed hands-on by **Jaden Maciel-Shapiro**. Timeline: **2025-11**. Focus: secure SOHO topology, addressing/NAT, selective inbound exposure for dev services, and multi-OS enablement. Portfolio use only.

