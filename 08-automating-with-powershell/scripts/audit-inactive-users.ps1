# Audit Inactive AD Users
# Usage: .\audit-inactive-users.ps1
# Output: inactive-users.csv

$cutoff = (Get-Date).AddDays(-30)
Get-ADUser -Filter {LastLogonDate -lt $cutoff -and Enabled -eq $true} `
    -Properties LastLogonDate | `
    Select-Object Name, SamAccountName, LastLogonDate | `
    Export-Csv "inactive-users.csv" -NoTypeInformation
Write-Host "Report saved to inactive-users.csv"
