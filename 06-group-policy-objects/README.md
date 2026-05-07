# 06 — Group Policy Objects (GPOs)

## Objective
Create and apply Group Policy Objects to enforce security settings and corporate configurations across users in the domain, then validate enforcement on the Windows 11 workstation.

---

## Snapshot
> **`OUs and Groups Done`** — starting point  
> **`GPOs Applied`** — taken after all policies verified on WS01

---

## GPOs Created

### GPO 1 — SetEngineeringBackground
**Linked to:** Engineering OU  
**Policy:** Desktop Wallpaper  
**Setting:** Custom wallpaper — "Stephen Thang Inc. Engineering Department"  
**Path:** User Configuration → Policies → Administrative Templates → Desktop → Desktop Wallpaper

### GPO 2 — Lock_desktop
**Linked to:** Engineering OU  
**Policy:** Prevent changing desktop background  
**Path:** User Configuration → Policies → Administrative Templates → Control Panel → Personalization → Prevent changing desktop background → Enabled

### GPO 3 — Account Lockout Policy
**Linked to:** Domain (Default Domain Policy)  
**Policy:** Account lockout threshold — 5 invalid logon attempts  
**Path:** Computer Configuration → Policies → Windows Settings → Security Settings → Account Policies → Account Lockout Policy

---

## Steps

### 1. Open Group Policy Management
Server Manager → Tools → Group Policy Management

### 2. Create and Link GPO
Right-click Engineering OU → Create a GPO and link it here

### 3. Edit GPO Settings
Right-click GPO → Edit → navigate to policy path → configure setting

### 4. Force Update on Client
```cmd
gpupdate /force
```

### 5. Verify Policies Applied
```cmd
gpresult /r
```

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-gpo-linked-to-engineering.png` | SetEngineeringBackground GPO linked to Engineering OU |
| 02 | `02-gpo-settings.png` | Wallpaper policy setting in GPO editor |
| 03 | `03-account-lockout-policy.png` | Account lockout threshold set to 5 attempts |
| 04 | `04-gpo-wallpaper-applied.png` | lab\jmon desktop showing Stephen Thang Inc. Engineering Dept wallpaper |
| 05 | `05-gpo-prevent-wallpaper-change.png` | Lock_desktop policy in GPO editor |
| 06 | `06-gpo-background-locked.png` | "Some of these settings are managed by your organization" — user cannot change wallpaper |
| 07 | `07-account-lockout-enforced.png` | Earl Young — "Invalid credentials, delaying next attempt" |

---

## Help Desk Ticket Documentation

### TICKET #001 — Enforce Engineering Department Wallpaper
**Request:** Set corporate wallpaper for all Engineering users  
**Solution:** Created SetEngineeringBackground GPO linked to Engineering OU  
**Result:** All Engineering users receive wallpaper automatically at login

### TICKET #002 — Prevent Users from Changing Wallpaper
**Request:** Users changing wallpaper away from corporate standard  
**Solution:** Enabled "Prevent changing desktop background" in Lock_desktop GPO  
**Result:** Settings page shows "managed by your organization" — change blocked

---

## Security Validation

| Test | Result | Policy |
|------|--------|--------|
| Josie Mon logs in → wallpaper applied | ✅ Pass | SetEngineeringBackground |
| Josie Mon tries to change wallpaper | ❌ Blocked | Lock_desktop |
| Earl Young enters wrong password 5x | ⚠️ Delayed/Locked | Account Lockout |

---

## Key Takeaways
- GPOs apply in order: Local → Site → Domain → OU (LSDOU) — OU-level GPOs win over domain-level for user settings
- `gpupdate /force` immediately applies policies without waiting for the 90-minute default refresh
- Account lockout policy directly maps to **NIST 800-53 AC-7** (Unsuccessful Logon Attempts)
- Corporate wallpaper with legal notices is a real compliance requirement in regulated industries
