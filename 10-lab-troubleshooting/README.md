# 10 — Lab Troubleshooting Log

## Objective
Document all issues encountered across the lab series and their resolutions. This log demonstrates real problem-solving ability — one of the most valuable skills in help desk and sysadmin work.

---

## Issue Log

### Issue 01 — VM Failed to Boot: "No Bootable Medium Found"
**Module:** 01 — Server 2022 VM Setup  
**Symptom:** VirtualBox showed "No bootable medium found! Please insert a bootable medium and reboot." DVD dropdown was blank.  
**Root Cause:** ISO was not attached to the VM at runtime. Boot order had Hard Disk before Optical.  
**Fix:**
1. Mounted ISO via Devices → Optical Drives during runtime
2. Corrected boot order: Settings → System → Optical first
3. Enabled UEFI and TPM 2.0 (required for Server 2022)
4. Moved ISO to IDE controller, VDI to SATA controller  
**Time to Resolve:** ~45 minutes  
**Lesson:** Windows Server 2022 requires UEFI and TPM 2.0. ISO and VDI should be on separate controllers. Always verify storage and system settings before first boot.

---

### Issue 02 — Black Screen After Boot
**Module:** 01 — Server 2022 VM Setup  
**Symptom:** VM showed black screen with blinking cursor after booting  
**Root Cause:** Server Core loading slowly with only 2GB RAM. LogonUI.exe was still initializing.  
**Fix:** Increased RAM to 4096 MB. Waited 30–60 seconds for CMD window to fully render.  
**Time to Resolve:** ~10 minutes  
**Lesson:** Server VMs need at least 4GB RAM. A black screen during boot is often just slow loading, not a crash. Check title bar for process name before assuming failure.

---

### Issue 03 — AD CS Blocking Domain Controller Promotion
**Module:** 02 — Domain Controller Configuration  
**Symptom:** Prerequisites check failed with "Certificate Server is installed" error  
**Root Cause:** AD Certificate Services (AD CS) was accidentally installed before AD DS promotion. AD CS and AD DS have a specific installation order — DC must be promoted first.  
**Fix:**
```powershell
Uninstall-WindowsFeature -Name AD-Certificate -IncludeManagementTools
Restart-Computer
# Then re-run DC promotion
```
**Time to Resolve:** ~30 minutes  
**Lesson:** Always install AD DS and promote to DC before adding any other roles. AD CS must come after DC promotion.

---

### Issue 04 — DC Promotion Appeared to Fail But Actually Succeeded
**Module:** 02 — Domain Controller Configuration  
**Symptom:** Install-ADDSForest kept returning errors about unrecognized parameters. Promotion appeared to fail repeatedly.  
**Root Cause:** Copy-paste inserted curly/smart quotes instead of straight quotes, causing parameter parsing failures. However, one of the earlier attempts actually succeeded silently before the error output appeared.  
**Discovery:** When opening the DC promotion wizard via GUI, it showed "The target server is already a Domain Controller" and the server name showed DC01.lab.local  
**Fix:** Verified with Get-ADDomain — domain was fully configured and operational.  
**Time to Resolve:** ~1 hour  
**Lesson:** Always verify actual system state rather than relying solely on command output. When copy-pasting PowerShell commands, smart quotes can silently corrupt parameters — type critical commands manually.

---

### Issue 05 — Windows 11 Cannot Find Domain / Ping Failing
**Module:** 04 — Windows 11 Domain Join  
**Symptom:** "That domain couldn't be found" and ping to DC timing out  
**Root Cause (Initial):** Both VMs on NAT — same IP (10.0.2.15) assigned to both, no routing between them  
**Root Cause (Secondary):** DC's DNS server was pointing to 192.168.1.1 instead of itself (127.0.0.1)  
**Root Cause (Final):** DC firewall blocking ICMP and DNS queries from Windows 11  
**Fix:**
1. Verified both VMs on NAT Network → ADNetwork1
2. Set static IP on Windows 11: 10.0.2.16, DNS: 10.0.2.15
3. Set DC DNS to point to itself: `Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1`
4. Disabled DC firewall: `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False`  
**Time to Resolve:** ~2 hours  
**Lesson:** DNS is the backbone of Active Directory. The DC must point to itself for DNS. Always verify with nslookup before attempting domain join.

---

### Issue 06 — Snapshot Restore Resets Network Configuration (Key Discovery)
**Module:** 04 — Windows 11 Domain Join  
**Symptom:** After restoring "Delete me snap" snapshot, Windows 11 lost network connectivity to DC every time  
**Root Cause:** VirtualBox snapshots capture the FULL machine state including network adapter settings. Restoring a snapshot rolled back the NAT Network ADNetwork1 configuration to whatever it was when the snapshot was taken.  
**Fix (discovered independently):** After every snapshot restore:
1. Power off VM
2. Go to Settings → Network BEFORE starting VM
3. Set Attached to: NAT Network, Name: ADNetwork1
4. THEN start VM and configure static IP  
**Time to Resolve:** ~30 minutes  
**Lesson:** This is a non-obvious VirtualBox behavior. Snapshot management must include network reconfiguration as a standard post-restore step. Documenting this saved significant future troubleshooting time.

---

## Summary Statistics

| Metric | Value |
|--------|-------|
| Total issues logged | 6 |
| Modules affected | 01, 02, 04 |
| Most common category | VM/Network configuration |
| Longest to resolve | Issue 05 (~2 hours) |
| Most impactful discovery | Issue 06 — snapshot network behavior |

---

## Key Troubleshooting Principles Applied

1. **Verify actual state** — don't trust command output alone (Issue 04)
2. **Isolate the layer** — network issues work from Layer 1 up (Issue 05)
3. **Check prerequisites** — role installation order matters (Issue 03)
4. **Document discoveries** — the snapshot finding (Issue 06) will save hours in future labs
5. **Trust your instincts** — the snapshot hypothesis (Issue 06) was identified through pattern recognition, not documentation
