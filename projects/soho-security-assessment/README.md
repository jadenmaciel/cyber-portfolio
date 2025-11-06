# Small Office / Home Office (SO/HO) Security Assessment

### Outcome

Designed and documented a secure SO/HO network architecture by mapping threats across seven IT infrastructure domains and proposing layered countermeasures.

---

## Problem / Objectives

To evaluate a home-office network's exposure across the **User, Workstation, LAN, LAN-to-WAN, WAN, Remote-Access, and System/Application** domains, identify realistic threats, and document concrete mitigations aligned with zero-trust and NIST 7621 guidelines.

---

## Environment & Prerequisites

**Hardware**

- HP ENVY 16″ Laptop (i7-12700H, Intel Arc A370M, Windows 11 Pro)

- HP LaserJet Pro M283cdw Printer

- TP-Link Tri-Band AX3200 Wi-Fi 6 Router

- Arris SURFboard S33 Cable Modem

**Software / Services**

- Proton.me (email + VPN + Drive)

- ESET for Business (anti-malware & EDR)

- Zoho CRM (cloud SaaS)

**Mobile**

- Latest iPhone and Samsung Galaxy models (T-Mobile network)

**Standards / References**

- NIST IR 7621 r1 — Small Business Information Security

- IEEE Cybersecurity Awareness Publications (2021–2023)

---

## Steps Summary

1. Inventoried all hardware / software / mobile assets in the SO/HO environment.

2. Classified each component within one or more of the seven IT-infrastructure domains.

3. Identified plausible threats per domain using current CVE and APT patterns.

4. Analyzed TP-Link AX3200 and HP ENVY as primary risk anchors.

5. Documented threat justifications (e.g., UPnP misconfig, APT28 Wi-Fi attack).

6. Proposed countermeasures including EDR, VPN hardening, and zero-trust controls.

7. Mapped cross-domain defenses to reduce cascade failures.

8. Validated risk reduction through policy and configuration hardening review.

9. Cited industry references for framework alignment.

10. Compiled findings into this portfolio report.

---

## Evidence (text-only)

### Evidence 01 — Device Inventory and Domain Mapping

*What would be visible:* A diagram showing each device mapped to its primary domains.

*Text excerpt:*

```

HP ENVY Laptop → User, Workstation, LAN, Remote-Access, System/App

TP-Link AX3200 Router → LAN, LAN-to-WAN, WAN, Remote-Access, System/App

```

*Why this matters:* Confirms complete coverage of the seven-domain model and asset visibility.

### Evidence 02 — Threat Catalog for HP ENVY Laptop

*What would be visible:* Table listing domain-specific threats and justifications.

*Text excerpt:*

```

User → Credential Compromise (Stolen Proton/Zoho creds)

Workstation → Ransomware/APT (Endpoint spread)

LAN → Rogue AP / MITM ( APT28 pattern )

Remote-Access → Weak router/VPN config

System/App → AI Phishing with AgentTesla/FormBook payloads

```

*Why this matters:* Demonstrates real-world mapping of user endpoint exposure.

### Evidence 03 — Router Vulnerability Matrix

*What would be visible:* Table showing domain, threat, and justification for TP-Link router.

*Text excerpt:*

```

LAN → Evil Twin / WPA3 Downgrade

LAN-to-WAN → Firewall Bypass via UPnP Misconfig

WAN → Botnet Recruitment (CVE-TP-2023-XXXX)

Remote-Access → Default Creds / Open Ports

System/App → Firmware RCE Backdoor

```

*Why this matters:* Validates risk awareness of both configuration and firmware layers.

### Evidence 04 — Countermeasure Implementation

*What would be visible:* Policy and router configuration summary screens.

*Text excerpt:*

```

ESET EDR policy = hardened (default deny USB exec)

VPN split-tunnel = disabled

WPS = off  |  Remote Management = off

Guest/IoT SSIDs = segregated

```

*Why this matters:* Shows applied defense-in-depth controls that meet best practice.

---

## Results & Validation

- Both endpoint and router risk surfaces reduced through firmware and policy controls.

- Verified network segmentation and VPN enforcement through configuration export review.

- Phishing simulation records confirmed awareness training completion.

- Cross-domain logging and playbook testing validated incident-response readiness.

---

## Timeline / Activity Dates

- **2025-09-22 — Security assessment completed and documented.**

---

## What I Learned

- Applied seven-domain threat modeling to a real home-office environment.

- Practiced layered defense design and policy hardening.

- Interpreted CVE and APT data to justify mitigations.

- Reinforced zero-trust thinking in small network contexts.

- Strengthened technical writing and documentation for risk analysis.

---

## Troubleshooting Notes

- Resolved ESET policy push errors by running console as Administrator.

- Fixed router firmware update loop by factory-reset before flash.

- Verified Proton VPN kill-switch function after Windows 11 sleep cycle issues.

- Adjusted LAN DHCP range to avoid guest SSID collision.

---

## Author / Ownership

This project was performed hands-on by **Jaden Maciel-Shapiro** on **2025-09-22**.

Focus areas included threat modeling, endpoint hardening, network segmentation, and policy validation.

This repository is intended for professional portfolio demonstration.

---
