# Cybersecurity Projects Portfolio

A single, curated repo for my security projects. Each folder is a standalone project with its own README and preserved commit history (via `git subtree`).

## Projects

### Cloud Security
- **Cloud Guardrails Lab** → `projects/cloud-guardrails-lab`
- **SOHO Security Assessment** → `projects/soho-security-assessment`

### Windows Server & Infrastructure
- **File Server Role Configuration** → `projects/file-server-role`
- **IIS Server Role Configuration** → `projects/project-iis-server-role`
- **Windows Domain Deployment** → `projects/windows-domain-deployment`
- **Windows Registry Hardening Playbook** → `projects/windows-registry-hardening-playbook`
- **Windows Server 2025 Installation** → `projects/windows-server-2025-installation`
- **Windows Server 2025 Installation 2** → `projects/windows-server-2025-installation-2`
- **Windows Server Configuration** → `projects/windows-server-configuration`
- **WSUS Domain Update Hub** → `projects/wsus-domain-update-hub`

### Security Tools & Analysis
- **DShield IDS Honeypot** → `projects/project-dshield-ids-honeypot`
- **WiFi IDS Analysis** → `projects/wifi-ids-analysis`

### PowerShell & Automation
- **PowerShell ChatGPT Integration** → `projects/powershell-chatgpt`
- **PowerShell System & Network Audit** → `projects/powershell-system-network-audit`

### Encryption & Recovery
- **Cryptomator Encryption Project** → `projects/project-cryptomator-encryption`
- **Windows USB Recovery Toolkit** → `projects/windows-usb-recovery-toolkit`

### Networking & Infrastructure
- **SOHO Development Network** → `projects/project-soho-dev-network`

### What's inside each project

- Overview & goals
- Environment / setup
- Steps performed (commands + rationale)
- Evidence & outputs (text-based where possible)
- Risks & mitigations
- Lessons learned

## Syncing Projects

To pull updates from the original repositories, use `git subtree pull`:

```bash
# Example: sync wifi-ids-analysis
git fetch wifi-ids-analysis
git subtree pull --prefix=projects/wifi-ids-analysis wifi-ids-analysis main -m "chore(wifi-ids-analysis): sync from upstream"
```

**Note:** If you imported with `--squash`, add `--squash` to the pull command as well.

**Author:** Jaden Maciel • **Focus:** Cloud / DevSecOps / Security Engineering • **Updated:** 2025-11-06
