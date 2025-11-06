# PowerShell System & Network Audit

One-line outcome: run a single PowerShell session to collect system facts, switch an adapter to a static IP/DNS, and verify the change with before/after evidence.

## Problem / Objectives

- Rapidly **enumerate system state** (CPU, OS, disk, time, services, local users).

- **Inspect and modify network config** for a chosen adapter (IPv4 + DNS).

- **Prove the change** with before/after IP configuration and adapter properties.

## Environment & Prerequisites

- **OS:** Windows 11 Pro 23H2 (or Windows 10 22H2)

- **PowerShell:** 7.3+ (Windows PowerShell 5.1 works with equivalent cmdlets)

- **Permissions:** Administrator PowerShell session (required for network changes)

- **Network:** One active adapter (example uses `Wi-Fi`)

## Steps Summary

1. Open **PowerShell (Admin)**.

2. Collect baseline facts (examples):  

   - CPU/OS/Disk:  

     ```powershell

     Get-CimInstance Win32_Processor | Select Name,NumberOfCores,NumberOfLogicalProcessors

     Get-CimInstance Win32_OperatingSystem | Select Caption,Version,BuildNumber

     Get-CimInstance Win32_LogicalDisk | Where {$_.DriveType -eq 3} | Select DeviceID,@{n='Size (GB)';e={$_.Size/1GB -as [int]}},@{n='Free (GB)';e={$_.FreeSpace/1GB -as [int]}}

     ```

   - Time/Services/Accounts:  

     ```powershell

     Get-Date

     Get-Service | Where Status -eq 'Running' | Select -First 5 Name,Status

     Get-LocalUser | Select Name,Enabled

     Get-LocalGroupMember -Group Administrators | Select Name,PrincipalSource

     ```

3. Record **initial network** state (before changes):  

   ```powershell

   $AdapterName = 'Wi-Fi'

   Get-NetIPConfiguration -InterfaceAlias $AdapterName

   Get-NetAdapter -Name $AdapterName | Select Name,InterfaceDescription,Status,MacAddress

   ```

4. Switch adapter to **static IPv4 + gateway**:

   ```powershell

   $ifIndex = (Get-NetAdapter -Name $AdapterName).InterfaceIndex

   Remove-NetIPAddress -InterfaceIndex $ifIndex -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue

   New-NetIPAddress -InterfaceAlias $AdapterName -IPAddress '192.168.1.150' -PrefixLength 24 -DefaultGateway '192.168.1.1' | Out-Null

   ```

5. Set **DNS servers** (primary/secondary):

   ```powershell

   Set-DnsClientServerAddress -InterfaceAlias $AdapterName -ServerAddresses ('8.8.8.8','8.8.4.4') | Out-Null

   ```

6. Recollect **post-change** state (after changes):

   ```powershell

   Get-NetIPConfiguration -InterfaceAlias $AdapterName

   Get-NetAdapter -Name $AdapterName | Select Name,InterfaceDescription,Status,MacAddress,LinkSpeed

   ```

7. (Optional) Revert to **DHCP** later:

   ```powershell

   Set-DnsClientServerAddress -InterfaceAlias $AdapterName -ResetServerAddresses

   Set-NetIPInterface -InterfaceAlias $AdapterName -Dhcp Enabled

   ```

> Tip: For compact tables use formatters: `Get-Process | ft -auto` or lists via `fl`. Use column selections like `Get-Process | ft Name,Id,CPU`.

## Evidence & Artifacts

The source document includes **2 screenshots**. Mirror them in `/artifacts/` with these names:

1. `01-initial-ipconfig.png` — `Get-NetIPConfiguration -InterfaceAlias Wi-Fi` before changes.

2. `02-postchange-ipconfig.png` — `Get-NetIPConfiguration -InterfaceAlias Wi-Fi` after applying static IP/DNS.

## Results & Validation

* Adapter `Wi-Fi` shows **IPv4 192.168.1.150/24** with **DefaultGateway 192.168.1.1**.

* `Get-DnsClientServerAddress` reflects **8.8.8.8, 8.8.4.4**.

* `Get-NetIPConfiguration` (after) displays updated address/gateway/DNS.

* Host retains network connectivity appropriate for the configured subnet/gateway.

## What I Learned

* Object-based querying with **CIM** classes for reliable system interrogation.

* Safe **idempotent network reconfiguration** using `Remove-NetIPAddress` + `New-NetIPAddress`.

* Precise **adapter targeting** via `InterfaceAlias` and `InterfaceIndex`.

* **Before/after validation** patterns to prove changes with minimal ambiguity.

## Troubleshooting Notes

* **Access denied / no change:** Re-run in an **elevated** PowerShell window.

* **Adapter name mismatch:** Confirm with `Get-NetAdapter | Select Name,Status`.

* **Gateway conflicts:** Ensure gateway is reachable in your LAN; otherwise set a valid one.

* **IP already in use:** Pick an unused IP (`ping -n 1 <ip>` before assigning) or use DHCP.

* **Name resolution fails:** Verify DNS entries with `Resolve-DnsName` or reset DNS servers.

* **Execution policy blocks scripts:**

  ```powershell

  Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

  ```

---

### Appendix — Reference Script (optional to include in `/src/`)

```powershell

# src/system-network-audit.ps1

# Author: (you)

# Date: (today)



Write-Host "=========================================================="

Write-Host "--- Initial System Information Collection Started ---"

Write-Host "==========================================================`n"



Write-Host "--- 1. Processor Information ---"

Get-CimInstance Win32_Processor | Select Name,NumberOfCores,NumberOfLogicalProcessors

Write-Host ""



Write-Host "--- 2. Computer Manufacturer and Model ---"

Get-CimInstance Win32_ComputerSystem | Select Manufacturer,Model,SystemType

Write-Host ""



Write-Host "--- 3. Operating System Version ---"

Get-CimInstance Win32_OperatingSystem | Select Caption,Version,BuildNumber

Write-Host ""



Write-Host "--- 4. Available Disk Space ---"

Get-CimInstance Win32_LogicalDisk | Where {$_.DriveType -eq 3} | Select DeviceID,@{n='Size (GB)';e={$_.Size/1GB -as [int]}},@{n='Free (GB)';e={$_.FreeSpace/1GB -as [int]}}

Write-Host ""



Write-Host "--- 5. Local Time ---"

Get-Date

Write-Host ""



Write-Host "--- 6. Running Service Status (First 5) ---"

Get-Service | Where {$_.Status -eq 'Running'} | Select -First 5 Name,Status

Write-Host ""



Write-Host "--- 7. Local Users and Administrators ---"

Write-Host "All Local Users:"

Get-LocalUser | Select Name,Enabled

Write-Host "Local Administrators Group Members:"

Get-LocalGroupMember -Group Administrators | Select Name,PrincipalSource

Write-Host "`n--- Initial System Information Collection Complete ---`n"



Write-Host "=========================================================="

Write-Host "--- Network Configuration and Verification Started ---"

Write-Host "==========================================================`n"



$AdapterName = "Wi-Fi"

Write-Host "Target Adapter for Configuration: $AdapterName`n"



Write-Host "--- 8. Initial IP Configuration Data (BEFORE Change) ---"

Get-NetIPConfiguration -InterfaceAlias $AdapterName

Write-Host ""



Write-Host "--- 9. Initial Network Adapter Properties (BEFORE Change) ---"

Get-NetAdapter -Name $AdapterName | Select Name,InterfaceDescription,Status,MacAddress

Write-Host ""



Write-Host "--- Performing Network Configuration Changes (Setting Static IP/DNS)... ---"

$InterfaceIndex = (Get-NetAdapter -Name $AdapterName).InterfaceIndex

Remove-NetIPAddress -InterfaceIndex $InterfaceIndex -AddressFamily IPv4 -Confirm:$false -ErrorAction SilentlyContinue

New-NetIPAddress -InterfaceAlias $AdapterName -IPAddress "192.168.1.150" -PrefixLength 24 -DefaultGateway "192.168.1.1" | Out-Null

Set-DnsClientServerAddress -InterfaceAlias $AdapterName -ServerAddresses ("8.8.8.8", "8.8.4.4") | Out-Null

Write-Host "--- Network Configuration Changes Complete. Verifying... ---`n"



Write-Host "--- 10. Re-listed IP Configuration Data (AFTER Change) ---"

Get-NetIPConfiguration -InterfaceAlias $AdapterName

Write-Host ""



Write-Host "--- 11. Re-retrieved Network Adapter Properties (AFTER Change) ---"

Get-NetAdapter -Name $AdapterName | Select Name,InterfaceDescription,Status,MacAddress,LinkSpeed

Write-Host ""



Write-Host "--- Network Configuration and Verification Complete ---"

Write-Host "=========================================================="

```
