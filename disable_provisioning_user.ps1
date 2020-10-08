Param (
    [string]$Username
)

$ErrorActionPreference="Stop"

"Disabling user $Username..." | Write-Host
Disable-LocalUser -Name $Username

"Disabling user Administrator..." | Write-Host
Disable-LocalUser -Name Adminstrator

"disable_provisioning_user.ps1  - Done!" | Write-Host
