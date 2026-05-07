# Bulk Create AD Users from CSV
# Usage: .\bulk-create-users.ps1
# Requires: users.csv in the same directory

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
