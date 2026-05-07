# 08 — Automating Tasks with PowerShell

## Objective
Write PowerShell scripts to automate common help desk and AD administration tasks — bulk user creation, account auditing, and reporting.

---

## Snapshot
> **`Pre-PowerShell`** — restore here if scripts cause unintended changes.

---

## Scripts

### bulk-create-users.ps1
Creates multiple AD users from a CSV file.
```powershell
# users.csv format:
# FirstName,LastName,Department
# Jane,Smith,HR
# Bob,Jones,IT

Import-Csv "users.csv" | ForEach-Object {
    $username = ($_.FirstName[0] + $_.LastName).ToLower()
    New-ADUser `
        -Name "$($_.FirstName) $($_.LastName)" `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -SamAccountName $username `
        -UserPrincipalName "$username@lab.local" `
        -Department $_.Department `
        -AccountPassword (ConvertTo-SecureString "Welcome1!" -AsPlainText -Force) `
        -Enabled $true
    Write-Host "Created user: $username"
}
```

### audit-inactive-users.ps1
Finds users who haven't logged in for 30+ days.
```powershell
$cutoff = (Get-Date).AddDays(-30)
Get-ADUser -Filter {LastLogonDate -lt $cutoff -and Enabled -eq $true} `
    -Properties LastLogonDate | `
    Select-Object Name, SamAccountName, LastLogonDate | `
    Export-Csv "inactive-users.csv" -NoTypeInformation
Write-Host "Report saved to inactive-users.csv"
```

### reset-password.ps1
Resets a user password and forces change at next login.
```powershell
param([string]$Username)
Set-ADAccountPassword -Identity $Username `
    -NewPassword (ConvertTo-SecureString "TempPass123!" -AsPlainText -Force) `
    -Reset
Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
Write-Host "Password reset for $Username"
```

---

## Screenshots

| # | Filename | Description |
|---|----------|-------------|
| 01 | `01-csv-import.png` | CSV file and bulk creation script |
| 02 | `02-users-created-output.png` | Script output confirming users created |
| 03 | `03-audit-report.png` | Inactive users report CSV |
| 04 | `04-password-reset-script.png` | Password reset script running |

---

## Key Takeaways
- `Import-Csv` + `ForEach-Object` is the standard pattern for bulk AD operations
- Always test scripts with `-WhatIf` flag before running against production AD
- `Export-Csv` is useful for generating reports that can be opened in Excel
- `param()` blocks make scripts reusable with different inputs
