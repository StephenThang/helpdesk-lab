# 07 — Intro to PowerShell

## Objective
Learn foundational PowerShell commands for Windows Server administration, building the skills needed for AD automation in Module 08.

---

## Snapshot
> **`Pre-PowerShell`** — taken before running any scripts that modify the system.

---

## Key Commands Reference

### Navigation & Files
```powershell
Get-Location              # Show current directory (like pwd)
Set-Location C:\          # Change directory (like cd)
Get-ChildItem             # List files (like ls/dir)
New-Item -ItemType File -Name "test.txt"
Remove-Item "test.txt"
```

### Services & Processes
```powershell
Get-Service               # List all services
Get-Service -Name "dns"   # Check specific service
Start-Service -Name "dns"
Stop-Service -Name "dns"
Get-Process               # List running processes
```

### System Info
```powershell
Get-ComputerInfo          # Full system information
Get-EventLog -LogName System -Newest 20   # Last 20 system events
ipconfig /all             # Network config (CMD command, works in PS)
```

### Active Directory Basics
```powershell
Get-ADUser -Filter *                        # List all AD users
Get-ADComputer -Filter *                    # List all computers
Get-ADGroup -Filter *                       # List all groups
Get-ADDomainController                      # DC info
```

### Help System
```powershell
Get-Help Get-ADUser             # Built-in help
Get-Help Get-ADUser -Examples   # Show examples
Get-Command *ADUser*            # Find commands related to ADUser
```

---

## Scripts

See `scripts/` folder for practice scripts from this module.

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-ps-navigation.png` | Basic navigation commands |
| 02 | `02-get-service.png` | Checking service status |
| 03 | `03-ad-commands.png` | AD user/computer queries |

---

## Key Takeaways
- PowerShell uses Verb-Noun syntax (Get-Service, Set-Location, New-ADUser)
- `Get-Help` is your best friend — always check it before Googling
- Everything in PowerShell returns objects, not just text — this is why you can pipe and filter results
- AD module commands (`Get-ADUser`, etc.) only work after installing RSAT or on a DC
