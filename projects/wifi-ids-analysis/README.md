# Wi-Fi Scanning & Intrusion Detection — Mini Project



One-day, hands-on exploration of local Wi-Fi spectrum with inSSIDer and practical intrusion-detection concepts (diary analysis, anomaly triage, DNS checks, and honeypot prep), documented with reproducible steps and evidence.



---



## Problem / Objectives



- Inspect nearby Wi-Fi networks to understand congestion, encryption posture, and channel planning.

- Translate real-world tradecraft into executive-ready takeaways and IR actions.

- Practice anomaly-based triage decisions with concrete responses and validation sources.

- Use DNS tools to compare resolver views and record authoritative IPs.

- Prep an Ubuntu VM path to deploy a lightweight honeypot for high-fidelity alerts.



---



## Environment & Prerequisites



- **OS:** Windows 11 (22H2+) for Wi-Fi scanning; Ubuntu Server 22.04 LTS (VirtualBox) for honeypot notes.

- **Hardware:** Laptop with integrated Wi-Fi adapter (802.11ac or better).

- **Tools:**

  - **inSSIDer (Windows)** — MetaGeek Wi-Fi scanner (free tier).

  - **VirtualBox** — VM host for Ubuntu Server.

  - **Ubuntu 22.04** — minimal install.

  - **Browser** — for diary reading and DNS lookups.

- **Networking:** Internet connectivity (2.4 GHz + 5 GHz APs in range).



---



## Steps Summary



1. **Install inSSIDer (Windows):** create account → download → install → **Start Scanning** with your Wi-Fi adapter selected.

2. **Enumerate networks:** let results stabilize; record **visible network count**, **encryption**, and **channel usage** (2.4/5 GHz).

3. **Capture artifacts (3 screenshots total):** main dashboard; 2.4 GHz channels; 5 GHz channels.

4. **Summarize findings:** note crowding, overlapping channels (e.g., `1/6/11`), any legacy **WEP/WPA** detections, and mitigations (channel change, 5/6 GHz preference).

5. **Read a malware/IR diary:** extract initial vector, obfuscation, payload, and C2 indicators; convert to **exec-level** controls.

6. **Anomaly triage practice:** handle after-hours logins by correlating **SSO/DC, VPN, EDR, badge, camera**; define containment (isolate host, kill suspicious `powershell.exe`, reset creds, enforce MFA).

7. **DNS comparison:** query a few high-reliability domains; note US IP answers and geo variance.

8. **VM preparation (Ubuntu in VirtualBox):** create VM → `sudo apt update && sudo apt -y upgrade` → install essentials (`curl`, `git`); outline honeypot steps.



---



## Evidence & Artifacts (exactly 3 screenshots)



Place these under `/artifacts/` in this order:



1. `01-inssider-main.png` — Main inSSIDer window with RF graphs and AP table (shows overall count & encryption mix).

2. `02-inssider-24ghz-channels.png` — 2.4 GHz channel usage (e.g., activity on **1/6/11** and any overlapping channels).

3. `03-inssider-5ghz-channels.png` — 5 GHz distribution (e.g., activity across DFS/non-DFS ranges).



---



## Results & Validation



- **Wi-Fi visibility:** **44** networks detected.

- **Legacy encryption:** **Yes** — **1** legacy network (WEP/WPA) observed; others **WPA2/WPA3**.

- **2.4 GHz channels:** Predominantly **1/6/11**; at least one AP overlapping.

- **5 GHz activity:** Concentrated between **100–140** (DFS), plus non-DFS where available.

- **Mitigations applied:** Prefer 5/6 GHz, move any 2.4 GHz AP to cleaner **1/6/11**, reduce channel width to **20 MHz** on 2.4 GHz; position APs to minimize attenuation.



---



## What I Learned



- Interpreting RF/channel maps to drive concrete Wi-Fi changes (channel/width/band selection).

- Identifying legacy encryption risks and prioritizing WPA2/WPA3.

- Turning threat-diary insights into SOC detections & IR playbooks.

- Correlating identity, network, and endpoint telemetry for anomaly validation.

- Using DNS views to spot inconsistencies and geo-dependent answers.

- Standing up a minimal Linux VM and outlining honeypot deployment.



---



## Troubleshooting Notes



- **No networks in inSSIDer:** pick the correct adapter; update Wi-Fi drivers; disable airplane mode; some VPNs block scans.

- **VirtualBox vs Hyper-V:** disable Hyper-V if bridged networking fails (`Windows Features` → uncheck Hyper-V/Hypervisor Platform; reboot).

- **VM networking:** **Bridged** for inbound visibility; **NAT** for general use.

- **Linux capture permissions:** add user to `netdev/wireshark` or run with `sudo`.

- **PowerShell execution policy (Windows scripts):** `Set-ExecutionPolicy -Scope Process Bypass` (session-scoped; revert after).



---



## Credits & References



- RF scanning results captured locally with inSSIDer; counts & channels summarized from observed output.
