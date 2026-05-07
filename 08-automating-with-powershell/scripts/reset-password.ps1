# Reset AD User Password
# Usage: .\reset-password.ps1 -Username "jdoe"

param([string]$Username)

Set-ADAccountPassword -Identity $Username `
    -NewPassword (ConvertTo-SecureString "TempPass123!" -AsPlainText -Force) `
    -Reset

Set-ADUser -Identity $Username -ChangePasswordAtLogon $true

Write-Host "Password reset for $Username. User must change password at next login."
