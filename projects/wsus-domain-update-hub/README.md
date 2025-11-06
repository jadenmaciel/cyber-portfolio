<!-- README.md -->

# WSUS Domain Update Hub

**One-line outcome:** Built a Windows Server Update Services (WSUS) update hub and enforced domain-wide update policies with Group Policy Objects (GPO), validating client/server compliance end-to-end.



## Problem / Objectives

Keep Windows servers and clients consistently patched from a single internal source—without each device reaching out to Microsoft. Objectives:

- Stand up a WSUS server that synchronizes only relevant products/classifications.

- Enforce domain machines to use WSUS via GPO.

- Approve updates by device group (servers vs. clients).

- Validate policy application and end-to-end synchronization/approval flow.



## Environment & Prerequisites

- **Virtualization:** Oracle VirtualBox (current stable)

- **Directory Services:** One Active Directory domain controller (Windows Server 2025)

- **WSUS Host:** Windows Server 2025 (Desktop Experience), joined to the domain

- **Client:** Windows 11 domain-joined VM

- **Networking:** Internal network for domain; WSUS host also has NAT adapter for internet access

- **Storage:** `C:\WSUS` for update content

- **Permissions:** Domain Admin on DC and WSUS server; local admin on client



> Sensible defaults used where unspecified (e.g., Server 2025 + Windows 11, port **8530** for WSUS HTTP).



## Steps Summary

1. **Provision WSUS VM:** Create a Windows Server 2025 VM; allocate ≥4 GB RAM, ≥2 vCPU; join it to the domain; set static IP and timezone.

2. **Add WSUS role:** In Server Manager → *Add Roles and Features* → WSUS; set content path to `C:\WSUS`; complete **Post-Installation Tasks**.

3. **Internet access:** Add **Adapter 2** in VirtualBox (NAT). Confirm outbound with `ping google.com`.

4. **Initial WSUS setup:** Tools → **Windows Server Update Services** → run configuration wizard. Sync from Microsoft Update; language **English** only.

5. **Scope products:** Include Windows Server 2025 / Windows 11 components in the **Windows** section (e.g., **Microsoft Defender Antivirus**, **Microsoft Edge**). Exclude products not in use (e.g., Office suites if none installed).

6. **Choose classifications:** Select **Security Updates** and **Critical Updates** (sane minimum); set daily auto-sync; begin initial synchronization.

7. **Create Computer Groups:** In WSUS console → *Computers*: add **Servers** and **Clients**; move devices out of **Unassigned**.

8. **Create GPO:** Domain-level GPO "WSUS Configuration".

   - **Configure Automatic Updates:** Enable → `4 - Auto download and schedule the install`; schedule weekend maintenance.

   - **Specify intranet Microsoft update service location:** `http://<WSUS-SERVER-NAME>:8530` for both service and statistics.

   - **Automatic Updates detection frequency:** Enable → `1` hour (for faster validation).

9. **Force policy + announce to WU Agent (server/client):**

   ```bat

   gpupdate /force

   gpresult /r

   wuauclt /detectnow

   wuauclt /reportnow

   ```

10. **Approve updates:** In WSUS → *Updates* → filter by **Critical Updates** (and **Security Updates** if enabled). Approve server-relevant updates for **Servers**, client-relevant for **Clients**.

11. **Validate compliance:** On each machine, open **Windows Update → View configured update policies**; confirm WSUS intranet service and scheduling policies are listed.

12. **Observe synchronization:** In WSUS → *Synchronizations* → verify **Synchronization Details** shows successful completion.



## Evidence (Text-Based, No Screenshots)



Concrete, checkable signals that demonstrate the build and policy enforcement were completed:



* **WSUS Post-Install Completion:** In Server Manager → *Notifications*, the **Post-Installation Tasks** entry shows a green check with "Configuration successfully completed."

  *What to look for:* Task Details pane includes the WSUS content directory you set (e.g., `C:\WSUS`) and completion timestamp.



* **Connectivity Verified from WSUS Host:** A terminal session shows successful outbound pings.



  ```bat

  ping google.com

  ping 8.8.8.8

  nslookup microsoft.com

  ```



  *What to look for:* Replies <50ms for local network; `nslookup` returns authoritative/non-authoritative answer confirming DNS.



* **WSUS Configuration Wizard Finished:** The wizard's **Start Connecting** phase completed, then pages for **Products** and **Classifications** were saved.

  *What to look for:* Final page summary lists Microsoft Update as the upstream source, English language only, and your chosen daily sync schedule.



* **Products Scoped to Windows Server + Windows 11:** Products list shows Windows platform entries checked (e.g., *Windows Server 2025*, *Windows 11*, *Microsoft Defender Antivirus*, *Microsoft Edge*) and non-used products left unchecked.

  *Why this matters:* Minimizes catalog size and download storage.



* **Classifications Limited:** Only **Security Updates** and **Critical Updates** are selected.

  *Why this matters:* Reduces noise and focuses on risk-reducing patches.



* **Successful Synchronization:** In WSUS → *Synchronizations*, the most recent run displays **Result: Succeeded** with counts for updates and a completion timestamp.

  *What to look for:* The **Synchronization Details** pane shows total updates synchronized and "100% complete."



* **Computer Grouping in WSUS:** Under *Computers*, custom groups **Servers** and **Clients** exist; **Unassigned Computers** count is zero or reduced.

  *What to look for:* Devices appear under the intended groups after policy application and detection.



* **GPO Settings—Automatic Updates:** In Group Policy Management Editor, **Configure Automatic Updates** is *Enabled* with option `4 - Auto download and schedule the install`; scheduled day/time visible.

  *Why this matters:* Enforces consistent, predictable install cadence.



* **GPO Settings—WSUS URLs:** **Specify intranet Microsoft update service location** is *Enabled* with both boxes set to `http://<WSUS-SERVER-NAME>:8530`.

  *What to look for:* Both the service and statistics URL fields are identical and resolve from clients.



* **Client-Side Policy Confirmation (Server + Windows 11):** On each machine, **Windows Update → View configured update policies** displays the applied settings, including the intranet service URL and detection frequency.

  *What to look for:* "Policies set on your device" lists the WSUS URLs and the scheduled install configuration.



* **Command-Line Proof of Policy:** Running the following confirms GPO application and forces reporting:



  ```bat

  gpupdate /force

  gpresult /r

  wuauclt /detectnow

  wuauclt /reportnow

  ```



  *What to look for:* `gpresult /r` shows the "WSUS Configuration" GPO under **Applied Group Policy Objects**; `wuauclt` returns without error.



* **Update Approvals per Group:** In WSUS → *Updates*, context menus or the right pane show **Approve…** operations with target groups **Servers** or **Clients**.

  *What to look for:* Post-approval, update status shows "Approved" for the relevant group.



* **Policy Impact Visible in Client UI:** Windows Update's main page indicates updates are "managed by your organization," and install behavior conforms to the scheduled window after detection.



## Results & Validation



* **WSUS synchronization completed** with latest catalogs for selected products/classifications.

* **GPO applied** on server and client (`gpresult /r` lists "WSUS Configuration"; Windows Update policy screen shows intranet update service and schedule).

* **Updates approved per group**: Servers and Clients each have applicable approved updates.

* **Detection reporting works**: `wuauclt /detectnow` + `wuauclt /reportnow` reflected in WSUS console (after a short delay).



## What I Learned



* Curating **products/classifications** reduces storage, bandwidth, and approval noise.

* Using **GPO** to centralize update behavior outperforms ad-hoc device configuration.

* **Computer groups** in WSUS enable targeted rollouts (e.g., servers first, clients later).

* Faster validation by temporarily shortening **detection frequency** (1h) during buildout.

* Reading **Synchronization Details** is key to separating catalog sync vs. content downloads.



## Troubleshooting Notes



* **Post-install tasks stuck**: Restart the **WSUS Service** and **IIS** (`iisreset`), ensure `C:\WSUS` exists and has NTFS permissions.

* **No internet from WSUS VM**: Add **Adapter 2 (NAT)**; confirm DNS; test with `ping 8.8.8.8` and `nslookup`.

* **GPO not applying**: Verify link at **domain level**, check **Security Filtering** includes *Authenticated Users*, run `gpupdate /force`, inspect `Event Viewer → GroupPolicy`.

* **Clients not appearing in WSUS**: Ensure they contacted WSUS (policy URLs correct), then wait or run `wuauclt /detectnow` and `wuauclt /reportnow`.

* **Approvals have no effect**: Ensure update **classification** matches what you synchronized; verify device **group membership**.



---
