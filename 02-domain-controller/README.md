# 02 — Configuring Server as a Domain Controller

## Objective
Promote the Windows Server 2022 VM to an Active Directory Domain Controller, establishing the foundation domain for all subsequent lab modules.

---

## Environment
| Component | Details |
|-----------|---------|
| Server OS | Windows Server 2022 Standard Evaluation |
| Role Added | Active Directory Domain Services (AD DS) |
| Domain Name | (your domain name here, e.g. lab.local) |

---

## Snapshot
> **`Pre-DC Promotion`** — taken before promoting server to Domain Controller. Restore here if promotion fails or needs to be redone.  
> **`DC Configured`** — taken after successful promotion and reboot.

---

## Steps

### 1. Set a Static IP Address
Before promoting to DC, assign a static IP so the domain controller address doesn't change.
```powershell
# View current network adapters
Get-NetIPAddress

# Set static IP (adjust values to your network)
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.1.10 -PrefixLength 24 -DefaultGateway 192.168.1.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
```

### 2. Rename the Server (Optional but Recommended)
```powershell
Rename-Computer -NewName "DC01" -Restart
```

### 3. Install AD DS Role
```powershell
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
```

### 4. Promote to Domain Controller
```powershell
Install-ADDSForest `
  -DomainName "lab.local" `
  -DomainNetBiosName "LAB" `
  -InstallDns:$true `
  -Force:$true
```
Server will restart automatically after promotion.

### 5. Verify Domain Controller
```powershell
# Confirm AD DS is running
Get-Service adws, kdc, netlogon, dns

# Check domain info
Get-ADDomain
```

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-static-ip-set.png` | Static IP configured |
| 02 | `02-adds-install.png` | AD DS role installation |
| 03 | `03-dc-promotion.png` | Promotion command running |
| 04 | `04-reboot-complete.png` | Server rebooted as DC |
| 05 | `05-domain-verified.png` | Get-ADDomain output confirming domain |

---

## Issues Encountered & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| | | |

---

## Key Takeaways
- A static IP is essential before DC promotion — DHCP addresses change and break DNS resolution
- DNS is automatically installed with AD DS — the DC points to itself (127.0.0.1) as DNS server
- After promotion the server must reboot — this is normal
- `Get-ADDomain` is a quick health check to confirm the domain is functioning
