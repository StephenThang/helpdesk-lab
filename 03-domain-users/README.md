# 03 — Creating Domain Users

## Objective
Create and manage user accounts within Active Directory, simulating a real help desk onboarding workflow.

---

## Snapshot
> **`DC Configured`** — starting point for this module.  
> **`Users Created`** — taken after all users are created and verified.

---

## Steps

### 1. Create a Single User
```powershell
New-ADUser `
  -Name "John Doe" `
  -GivenName "John" `
  -Surname "Doe" `
  -SamAccountName "jdoe" `
  -UserPrincipalName "jdoe@lab.local" `
  -AccountPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) `
  -Enabled $true
```

### 2. Verify User Was Created
```powershell
Get-ADUser -Identity "jdoe"
Get-ADUser -Filter * | Select-Object Name, SamAccountName, Enabled
```

### 3. Modify User Properties
```powershell
Set-ADUser -Identity "jdoe" -Department "IT" -Title "Help Desk Technician"
```

### 4. Disable/Delete a User
```powershell
Disable-ADAccount -Identity "jdoe"
Remove-ADUser -Identity "jdoe" -Confirm:$false
```

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-new-user-created.png` | New-ADUser command output |
| 02 | `02-users-listed.png` | Get-ADUser listing all users |
| 03 | `03-user-properties.png` | User properties after modification |

---

## Issues Encountered & Fixes

| Issue | Cause | Fix |
|-------|-------|-----|
| | | |

---

## Key Takeaways
- `SamAccountName` is the login name (pre-Windows 2000 format), `UserPrincipalName` is the email-style login
- Passwords must meet complexity requirements by default in AD
- Always verify user creation with `Get-ADUser` before moving on
