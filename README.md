# Practical Help Desk Lab — Stephen Vanlian Thang

A hands-on IT administration lab series covering Active Directory, Domain Controller setup, Group Policy, and PowerShell automation in a virtualized Windows Server 2022 environment. Built as part of the TCM Practical Help Desk course, fully documented for portfolio purposes.

**Author:** Stephen Vanlian Thang  
**Completed:** May 2026  
**Environment:** Oracle VirtualBox | Windows Server 2022 | Windows 11  
**Status:** ✅ Complete

---

## Skills Demonstrated

- Windows Server 2022 installation, configuration, and troubleshooting
- Active Directory Domain Services (AD DS) — domain controller promotion
- Organizational Unit (OU) design and user/computer management
- Role-Based Access Control (RBAC) via security groups
- SMB file share creation and permission enforcement
- Group Policy Object (GPO) creation, linking, and verification
- Account lockout policy — brute force prevention (NIST AC-7)
- PowerShell scripting for AD user automation
- Help desk workflows — password resets, account unlocks, access troubleshooting
- Multi-VM networking — NAT Network configuration, static IP, DNS resolution
- VirtualBox snapshot management and rollback procedures

---

## Lab Modules

| # | Module | Snapshot | Status |
|---|--------|----------|--------|
| 01 | [Server 2022 VM Setup](./01-server-2022-setup/README.md) | `Fresh Install` | ✅ Complete |
| 02 | [Configuring Server as Domain Controller](./02-domain-controller/README.md) | `Pre-DC Promotion` → `DC Configured` | ✅ Complete |
| 03 | [Creating Domain Users](./03-domain-users/README.md) | `DC Configured` → `Users Created` | ✅ Complete |
| 04 | [Attaching Windows 11 VM to Domain](./04-windows11-domain-join/README.md) | `Users Created` → `Win11 Joined` | ✅ Complete |
| 05 | [Organizational Units and Groups](./05-ou-and-groups/README.md) | `Win11 Joined` → `OUs and Groups Done` | ✅ Complete |
| 06 | [Group Policy Objects](./06-group-policy-objects/README.md) | `OUs and Groups Done` → `GPOs Applied` | ✅ Complete |
| 07 | [Intro to PowerShell](./07-powershell-intro/README.md) | `Pre-PowerShell` | ✅ Complete |
| 08 | [Automating Tasks with PowerShell](./08-automating-with-powershell/README.md) | `Pre-PowerShell` | ✅ Complete |
| 09 | [Resetting AD Passwords](./09-resetting-ad-passwords/README.md) | `GPOs Applied` | ✅ Complete |
| 10 | [Lab Troubleshooting Log](./10-lab-troubleshooting/README.md) | N/A | ✅ Complete |

---

## Environment

| Component | Details |
|-----------|---------|
| Host OS | Windows 10 Home |
| Hypervisor | Oracle VirtualBox 7.x |
| Server OS | Windows Server 2022 Standard Evaluation |
| Client OS | Windows 11 Enterprise Evaluation |
| Server VM RAM | 4096 MB |
| Network | NAT Network — ADNetwork1 |
| Domain | lab.local |
| DC Hostname | DC01 |
| Client Hostname | WS01 |

---

## Domain Users Created

| Name | Username | OU | Department |
|------|----------|----|------------|
| Josie Mon | lab\jmon | Engineering | Engineering |
| Nelson King | lab\nking | Engineering | Engineering |
| Roy Rogers | lab\rrogers | Management | Management |
| Earl Young | lab\eyoung | Management | Management |

---

## Key Security Configurations

| Control | Setting | Purpose |
|---------|---------|---------|
| Account Lockout Threshold | 5 attempts | Brute force prevention (NIST AC-7) |
| GPO — Desktop Wallpaper | Stephen Thang Inc. Engineering Dept | Corporate branding compliance |
| GPO — Prevent Background Change | Enabled | Policy enforcement |
| RBAC — EngineeringShare | Engineering group members only | Least privilege file access |
| Password Reset Policy | Force change at next logon | Credential security |

---

## Tools Used

`VirtualBox` `Windows Server 2022` `Active Directory` `Group Policy Management` `PowerShell` `VS Code` `SMB File Sharing` `DNS` `Remote Desktop`
