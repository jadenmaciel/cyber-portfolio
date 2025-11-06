# DShield IDS + Honeypot Project

One-line outcome: Reviewed a real-world malware diary, analyzed anomaly-based login alerts,
queried DNS Looking Glass from the US, and stood up a honeypot on Ubuntu to generate
high-signal detection artifacts. :contentReference[oaicite:32]{index=32}

> Original source document is stored in `/docs/` for reference (not embedded here).
> Key prompts, tasks, IPs, and deliverables map directly to that source.
> :contentReference[oaicite:33]{index=33}

---

## Problem / Objectives

- Translate threat-intel reading ("Remcos Downloader with Unicode Obfuscation") into
  executive-level understanding and defensive actions. :contentReference[oaicite:34]{index=34}
- Practice anomaly-based incident response decisions for off-hours logins
  (legit vs. suspicious, response playbook). :contentReference[oaicite:35]{index=35}
- Use DShield DNS Looking Glass and record US-resolved IPs for selected FQDNs.
  :contentReference[oaicite:36]{index=36}
- Deploy a honeypot on Ubuntu to capture attacker touchpoints safely.
  :contentReference[oaicite:37]{index=37}

---

## Environment & Prerequisites

- Host OS: Windows 11 (22H2+) or macOS 13+ (common desktop defaults)

- Hypervisor: Oracle VirtualBox 7.x

- Guest: **Ubuntu Server 22.04 LTS** (1 vCPU, 2 GB RAM, 20 GB disk,
  NAT or bridged as needed)

- Network: Internet connectivity outbound; no inbound exposure from production
  LAN

- Browser: Latest Chrome/Edge/Firefox

- Accounts/Links:

  - DShield site and tools (Diaries, DNS Looking Glass, Honeypot guide)

  - YouTube access for reference video (for honeypot value discussion)

> Sensible defaults are used where the source did not mandate exact versions.

---

## Steps Summary (6–12 bullets)

1. **Threat-intel read-through:** Open DShield Diaries entry on **Remcos Downloader with
   Unicode Obfuscation**; note the VBS → PowerShell → DLL-in-memory chain and
   Unicode/base64 obfuscation themes for evasion. :contentReference[oaicite:38]{index=38}

2. **Executive brief (CIO-level):** Summarize what Remcos is, how it spreads, targeted
   system types (Windows endpoints, VBS/PowerShell), and high-leverage detections
   (unusual PowerShell, IOCs/C2). :contentReference[oaicite:39]{index=39}

3. **Anomaly IR drill:** Evaluate off-hours logins for "Bob," document legit vs.
   suspicious explanations, and lay out a measured response (disable, MFA reset,
   EDR triage, ticketing). :contentReference[oaicite:40]{index=40}

4. **Evidence correlation:** Plan cross-logs to confirm whether Bob actually logged in
   (Windows Security/DC/SSO, VPN concentrator, EDR telemetry, badge/camera).
   :contentReference[oaicite:41]{index=41}

5. **DNS Looking Glass (US):** Submit queries and **record the US IPs** for the FQDNs
   from the source:

   - `google.com → 142.250.69.238`

   - `bing.com → 150.171.27.10`

   - `github.com → 140.82.112.3`

   - `instagram.com → 57.144.194.34`  :contentReference[oaicite:42]{index=42}

6. **Ubuntu VM:** Create a clean Ubuntu Server 22.04 VM in VirtualBox; apply updates
   (`sudo apt update && sudo apt -y upgrade`).

7. **Honeypot deployment:** Follow the DShield honeypot instructions for Ubuntu
   (server variant vs. RPi image). Capture a **console screenshot** showing the service
   running. :contentReference[oaicite:43]{index=43}

8. **Reference links:** Note InfoSec Glossary and Fightback utilities as ancillary tools
   in the DShield toolset overview. :contentReference[oaicite:44]{index=44}

9. **Results & validation:** Confirm recorded IPs match your DNS queries (US vantage),
   anomaly responses are documented, and honeypot is active and logging.

---

## Evidence & Artifacts

1. `01-dshield-honeypot-console-running.png` — DShield honeypot status check output
   showing the service active on Ubuntu, including network configuration, report
   submission status, and system checks. :contentReference[oaicite:54]{index=54}

> Place this image under `/artifacts/` with the exact filename above.

---

## Results & Validation

- **Threat-intel comprehension:** Able to articulate Remcos downloader behavior, target
  platform (Windows), and detection points (PowerShell anomalies, IOC/C2 hits).
  :contentReference[oaicite:57]{index=57}

- **Anomaly IR reasoning:** Documented legitimate vs. suspicious causes; produced a
  proportionate response plan (disable/MFA reset/EDR triage/ticket).
  :contentReference[oaicite:58]{index=58}

- **DNS Looking Glass (US):** US-resolved IPs captured for four FQDNs as listed above.
  :contentReference[oaicite:59]{index=59}

- **Honeypot running:** Ubuntu service screen shows active honeypot ready to log inbound
  touches. :contentReference[oaicite:60]{index=60}

---

## What I Learned

- Translate threat-intel diaries into concrete detections (Unicode/base64 obfuscation
  patterns → PowerShell policy hardening & alerting). :contentReference[oaicite:61]{index=61}

- Differentiate benign exceptions from credential abuse in anomaly-based alerts using
  cross-log correlation. :contentReference[oaicite:62]{index=62}

- Use DNS Looking Glass to validate public DNS resolution from a specific geography and
  capture evidence cleanly. :contentReference[oaicite:63]{index=63}

- Deploy a safe-to-provoke honeypot to convert attacker reconnaissance into
  high-fidelity alerts.

---

## Troubleshooting Notes

- **VirtualBox networking:** If honeypot shows no hits, switch from NAT to **bridged** or
  add port-forward rules; verify guest IP and firewall.

- **Package updates on Ubuntu:** Run `sudo apt update && sudo apt -y upgrade` before
  installer scripts to avoid dependency errors.

- **Time skew & logs:** Ensure guest NTP is synced (`timedatectl status`) so
  cross-system timestamps align during correlation.

- **PowerShell detections (defender side):** Enforce `ConstrainedLanguageMode`, log
  module/script block events, and alert on `-EncodedCommand` patterns common in
  obfuscation.

- **Evidence capture:** Take screenshot full-frame with window title visible; save as
  PNG; name with zero-padded prefix (e.g., `01-dshield-honeypot-console-running.png`).

---

## /src/ (scripts)

The source did not provide concrete installer scripts; all actions were executed
manually following the DShield honeypot guide and DNS Looking Glass UI. If you later
export terminal histories, save them here as `ubuntu-honeypot-setup-notes.md` and
`dns-looking-glass-queries.md` (not fabricated now).

---
