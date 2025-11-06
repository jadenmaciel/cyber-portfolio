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

