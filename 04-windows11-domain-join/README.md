# 04 — Attaching Windows 11 VM to Domain

## Objective
Join a Windows 11 virtual machine to the lab.local Active Directory domain, then validate domain authentication by logging in as a domain user.

---

## Environment
| Component | Details |
|-----------|---------|
| Server | DC01 — 10.0.2.15 |
| Client | WS01 (Windows 11) — 10.0.2.16 |
| Network | NAT Network — ADNetwork1 |
| Domain | lab.local |

---

## Snapshots
> **`Users Created`** — starting point  
> **`Win11 Joined`** — taken after Windows 11 successfully joins domain and Roy Rogers logs in

---

## Steps

### 1. Configure Both VMs on Same Network
Both VMs must be on the same VirtualBox NAT Network:
- Settings → Network → Attached to: NAT Network
- Name: ADNetwork1

### 2. Set Static IP on Windows 11
Control Panel → Network → Ethernet → IPv4 Properties:
- IP: `10.0.2.16`
- Subnet: `255.255.255.0`
- Gateway: `10.0.2.1`
- DNS: `10.0.2.15` (DC's IP)

### 3. Disable Firewall on DC (Lab Only)
```powershell
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
```

### 4. Set DNS on DC to Point to Itself
```powershell
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 127.0.0.1
```

### 5. Verify Connectivity
```cmd
ping 10.0.2.15
nslookup lab.local
```

### 6. Join Domain via System Properties
- Win + R → `sysdm.cpl`
- Computer Name tab → Change
- Select Domain → type `lab.local`
- Enter Administrator credentials
- Restart when prompted

### 7. Verify in Active Directory
On DC — ADUC → Computers → WS01 appears confirming join

### 8. Log in as Domain User
At Windows 11 login → Other User → `LAB\rrogers`

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-network-config-both-vms.png` | Both VMs on ADNetwork1 |
| 02 | `02-win11-static-ip.png` | Static IP and DNS configured |
| 03 | `03-ping-success.png` | Successful ping to DC |
| 04 | `04-nslookup-success.png` | lab.local resolves to 10.0.2.15 |
| 05 | `05-domain-join-credentials.png` | Credentials prompt |
| 06 | `06-roy-rogers-logged-in.png` | Roy Rogers logged into WS01 |
| 07 | `07-whoami-domain-user.png` | whoami showing lab\rrogers |
| 08 | `08-ws01-in-active-directory.png` | WS01 in ADUC Computers container |

---

## Issues Encountered & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| "Domain couldn't be found" | VMs on NAT (different IPs) not routing between each other | Verified both on ADNetwork1, set static IPs |
| Ping timing out | DC firewall blocking ICMP | Disabled firewall via Set-NetFirewallProfile |
| DNS not resolving | DC pointing to wrong DNS server (192.168.1.1) | Set DC DNS to 127.0.0.1 (itself) |
| Domain join failing after snapshot restore | Snapshot rolled back network adapter settings | After every restore: reconfigure network adapter to NAT Network → ADNetwork1 BEFORE booting |

---

## Key Takeaways
- DNS is the backbone of Active Directory — if the DC doesn't point to itself for DNS, domain joins fail
- VirtualBox snapshots capture full machine state including network adapter settings — always verify network config after restore
- Disabling the firewall is acceptable in a lab environment but should never be done in production — use specific firewall rules instead
- `nslookup lab.local` is the fastest way to confirm DNS is working before attempting a domain join
