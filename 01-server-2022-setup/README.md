# 01 — Server 2022 VM Setup

## Objective
Install and configure Windows Server 2022 Standard Evaluation as a virtual machine in Oracle VirtualBox, preparing it as the foundation for an Active Directory lab environment.

---

## Environment
| Component | Details |
|-----------|---------|
| Host OS | Windows 10 Home |
| Hypervisor | Oracle VirtualBox 7.x |
| Guest OS | Windows Server 2022 Standard Evaluation |
| ISO | 26100.1.240331-1435.ge_release (6.39 GB) |
| RAM | 4096 MB |
| Storage | 50 GB VDI |

---

## Snapshot
> **`Fresh Install`** — taken immediately after OS installation completes, before any configuration.

---

## Steps

### 1. Download ISO
- Downloaded Windows Server 2022 Standard Evaluation ISO from Microsoft Evaluation Center
- File saved to `C:\Users\steph\Downloads\`

### 2. Create VM in VirtualBox
- New VM → Type: Microsoft Windows → Version: Windows 2022 (64-bit)
- Allocated 4096 MB RAM, 50 GB VDI storage

### 3. Configure Storage
- Settings → Storage → Added ISO to IDE Controller (optical drive)
- VDI hard disk attached to SATA Controller Port 0

### 4. Configure System Settings
- Boot Order: Optical first, then Hard Disk
- Enabled UEFI
- TPM Version set to TPM 2.0

### 5. Install Windows Server 2022
- Booted from ISO
- Selected: Windows Server 2022 Standard Evaluation (Desktop Experience) or Server Core
- Completed installation wizard, set Administrator password

### 6. Post-Install
- Logged in via SConfig menu (Server Core) or Desktop
- Confirmed OS version

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-virtualbox-new-vm.png` | New VM creation wizard |
| 02 | `02-storage-settings.png` | ISO attached to IDE controller |
| 03 | `03-system-settings.png` | Boot order and UEFI enabled |
| 04 | `04-windows-installer.png` | Windows Server installer boot screen |
| 05 | `05-install-complete.png` | Server booted and login screen |

---

## Issues Encountered & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| "No bootable medium found" | ISO not attached at runtime | Mounted ISO via Devices → Optical Drives |
| VM failed to boot | Boot order had Hard Disk before Optical | Moved Optical to top in System → Boot Order |
| Black screen after boot | Server Core loading slowly with 2GB RAM | Increased RAM to 4GB, waited for CMD to render |

---

## Key Takeaways
- UEFI and TPM 2.0 are required for Windows Server 2022 — legacy BIOS mode causes boot failures
- ISO should be on IDE controller; VDI on SATA — mixing both on SATA can cause boot detection issues
- Server Core has no GUI — managed via SConfig menu and PowerShell
- Always take a `Fresh Install` snapshot before making any changes
