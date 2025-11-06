# Import existing repos with history (git subtree)
# PowerShell version

# Edit these: "left side" = folder name; "right side" = your repo URL
$repos = @{
  "cloud-guardrails-lab"                  = "https://github.com/jadenmaciel/cloud-guardrails-lab.git"
  "file-server-role"                      = "https://github.com/jadenmaciel/file-server-role.git"
  "powershell-chatgpt"                    = "https://github.com/jadenmaciel/powershell-chatgpt.git"
  "powershell-system-network-audit"       = "https://github.com/jadenmaciel/powershell-system-network-audit.git"
  "project-cryptomator-encryption"         = "https://github.com/jadenmaciel/project-cryptomator-encryption.git"
  "project-dshield-ids-honeypot"          = "https://github.com/jadenmaciel/project-dshield-ids-honeypot.git"
  "project-iis-server-role"               = "https://github.com/jadenmaciel/project-iis-server-role.git"
  "soho-security-assessment"              = "https://github.com/jadenmaciel/soho-security-assessment.git"
  "wifi-ids-analysis"                     = "https://github.com/jadenmaciel/wifi-ids-analysis.git"
  "windows-domain-deployment"              = "https://github.com/jadenmaciel/windows-domain-deployment.git"
  "windows-registry-hardening-playbook"   = "https://github.com/jadenmaciel/windows-registry-hardening-playbook.git"
  "windows-server-2025-installation"      = "https://github.com/jadenmaciel/windows-server-2025-installation.git"
  "windows-server-2025-installation-2"    = "https://github.com/jadenmaciel/windows-server-2025-installation-2.git"
  "windows-server-configuration"          = "https://github.com/jadenmaciel/windows-server-configuration.git"
  "windows-usb-recovery-toolkit"          = "https://github.com/jadenmaciel/windows-usb-recovery-toolkit.git"
  "wsus-domain-update-hub"                = "https://github.com/jadenmaciel/wsus-domain-update-hub.git"
}

$defaultBranch = "main"

foreach ($name in $repos.Keys) {
  $url = $repos[$name]
  $dir = "projects/$name"

  Write-Host "Processing $name..." -ForegroundColor Cyan

  # Check if remote already exists, if not add it
  $remoteExists = git remote | Where-Object { $_ -eq $name }
  if (-not $remoteExists) {
    Write-Host "  Adding remote: $name" -ForegroundColor Yellow
    git remote add $name $url
    if ($LASTEXITCODE -ne 0) {
      Write-Host "  ERROR: Failed to add remote $name" -ForegroundColor Red
      continue
    }
  } else {
    Write-Host "  Remote $name already exists" -ForegroundColor Gray
  }

  # Fetch from remote
  Write-Host "  Fetching from $name..." -ForegroundColor Yellow
  git fetch $name
  if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: Failed to fetch from $name" -ForegroundColor Red
    continue
  }

  # Add subtree
  Write-Host "  Adding subtree: $dir" -ForegroundColor Yellow
  git subtree add --prefix="$dir" $name $defaultBranch -m "feat($name): import project"
  if ($LASTEXITCODE -ne 0) {
    Write-Host "  ERROR: Failed to add subtree for $name" -ForegroundColor Red
    continue
  }

  Write-Host "  Successfully imported $name" -ForegroundColor Green
  Write-Host ""
}

Write-Host "Import complete!" -ForegroundColor Green
