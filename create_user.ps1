Param (
    [string]$Username,
    [string]$Name,
    [string]$Password
)

$ErrorActionPreference="Stop"

"Creating user $Username..." | Write-Host
New-LocalUser -AccountNeverExpires -Name $Username -Fullname $Name -PasswordNeverExpires -Password $(ConvertTo-SecureString $password -AsPlainText -Force) | Out-Null

"Adding to administrators..." | Write-Host
Add-LocalGroupMember -Group "Administrators" -Member $Username

"create_user.ps1 - Done!" | Write-Host
