# 05 — Organizational Units, Groups, and File Shares

## Objective
Create a logical OU structure in Active Directory, organize users into departments, create security groups for resource access, and validate RBAC by testing access with both authorized and unauthorized users.

---

## Snapshot
> **`Win11 Joined`** — starting point  
> **`OUs and Groups Done`** — taken after RBAC validation is complete

---

## Steps

### 1. Create Organizational Units
In ADUC → right-click lab.local → New → Organizational Unit:

| OU | Sub-OU | Purpose |
|----|--------|---------|
| Engineering | — | Engineering department users |
| Management | — | Management department users |
| IT | Administrators | IT staff and admin accounts |

### 2. Move Users into OUs
Right-click user → Move → select OU:

| User | OU |
|------|----|
| Josie Mon | Engineering |
| Nelson King | Engineering |
| Roy Rogers | Management |
| Earl Young | Management |
| Administrator | IT → Administrators |

### 3. Move WS01 to Computers OU
ADUC → Computers → right-click WS01 → Move

### 4. Create EngineeringShare Security Group
ADUC → Engineering OU → New → Group:
- Group name: `EngineeringShare`
- Group scope: Global
- Group type: Security

Add members: Josie Mon, Nelson King, Roy Rogers

### 5. Create SMB File Share on DC
Server Manager → File and Storage Services → Shares → New Share:
- Path: `C:\Shares\EngineeringShare`
- Share name: `EngineeringShare`
- Permissions: EngineeringShare group — Read/Write

### 6. Map Network Drive on WS01
Logged in as Josie Mon (lab\jmon):
- File Explorer → Map Network Drive
- Drive Z: → `\\DC01\EngineeringShare`

### 7. Validate Access Control
- **lab\jmon (Engineering)** → ✅ Can access \\DC01\EngineeringShare
- **lab\eyoung (not in group)** → ❌ "You do not have permission to access"

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-ou-structure.png` | Engineering, Management, IT OUs created |
| 02 | `02-ou-structure-with-users.png` | Users moved into correct OUs |
| 03 | `03-it-administrators-subou.png` | Administrator in IT/Administrators sub-OU |
| 04 | `04-complete-ou-structure.png` | Full expanded OU tree |
| 05 | `05-engineeringshare-group-members.png` | EngineeringShare group members |
| 06 | `06-engineeringshare-smb-share.png` | Share created in Server Manager |
| 07 | `07-jmon-accessing-engineeringshare.png` | lab\jmon accessing share with whoami |
| 08 | `08-engineeringshare-mapped-drive.png` | Z: drive mapped on WS01 |
| 09 | `09-earlyoung-access-denied.png` | Earl Young denied access — RBAC working |

---

## Key Takeaways

**OU vs Security Group distinction:**
- OUs organize objects and apply GPOs
- Security Groups control access to resources
- They work together — users live in OUs, access resources through group membership

**RBAC validation result:**
```
lab\jmon (Engineering OU + EngineeringShare group member) → ACCESS GRANTED
lab\eyoung (Management OU + NOT in EngineeringShare group) → ACCESS DENIED
```

This demonstrates least privilege — users only access what their role requires. This is directly relevant to NIST 800-53 AC-3 (Access Enforcement) and AC-6 (Least Privilege).
