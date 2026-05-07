# 09 — Resetting AD Passwords

## Objective
Practice real help desk password reset workflows — resetting a locked out user's password via ADUC GUI, enforcing password change at next logon, and verifying the user can log back in.

---

## Snapshot
> **`GPOs Applied`** — starting point

---

## Help Desk Ticket

```
TICKET #003
User: Earl Young (lab\eyoung)
Issue: Account locked out after multiple failed login attempts
       (triggered by account lockout policy — 5 invalid attempts)
Priority: High — user cannot access workstation

Action Taken:
  1. Opened ADUC → searched for Earl Young in Management OU
  2. Right-clicked → Reset Password
  3. Set temporary password
  4. Checked "User must change password at next logon"
  5. Verified "Account Lockout Status: Unlocked" in dialog
  6. Clicked OK — confirmed password reset successful

Resolution: User logged in with temporary password,
  prompted to set new password, successfully authenticated
Time to Resolve: ~5 minutes
```

---

## Steps

### Method 1 — GUI (ADUC)
1. Open ADUC — `dsa.msc`
2. Find user — Action → Find → search by name
3. Right-click user → Reset Password
4. Enter temporary password
5. Check **"User must change password at next logon"**
6. Check **"Unlock the user's account"** if locked
7. Click OK

### Method 2 — PowerShell
```powershell
# Reset password
Set-ADAccountPassword -Identity "eyoung" `
    -NewPassword (ConvertTo-SecureString "TempPass123!" -AsPlainText -Force) `
    -Reset

# Force change at next login
Set-ADUser -Identity "eyoung" -ChangePasswordAtLogon $true

# Unlock if locked
Unlock-ADAccount -Identity "eyoung"

# Verify account status
Get-ADUser -Identity "eyoung" -Properties LockedOut, PasswordExpired, LastLogonDate
```

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-reset-password-earl-young.png` | Reset Password dialog — Account Lockout Status: Unlocked |
| 02 | `02-earl-must-change-password.png` | "User's password must be changed before signing in" |
| 03 | `03-earl-setting-new-password.png` | Earl Young setting new password at login |
| 04 | `04-earl-logged-in-after-reset.png` | Earl successfully logged in after reset |

---

## Key Takeaways
- Always check "User must change password at next logon" — never leave users with a permanent temp password
- "Account Lockout Status" is visible right in the Reset Password dialog — no need to check separately
- The full workflow: admin resets → user sees forced change prompt → user sets new password → access restored
- Document every password reset — protects both the technician and the user in case of dispute
- PowerShell method is faster for bulk resets or when managing many users
