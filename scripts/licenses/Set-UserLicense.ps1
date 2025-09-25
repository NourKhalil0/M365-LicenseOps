param(
    [Parameter(Mandatory)]
    [string]$UserPrincipalName,

    [Parameter(Mandatory)]
    [string]$SkuId,

    [ValidateSet("Add","Remove")]
    [string]$Action = "Add"
)

Connect-MgGraph -Scopes "User.ReadWrite.All"

$user = Get-MgUser -UserId $UserPrincipalName

if ($Action -eq "Add") {
    $body = @{ AddLicenses = @(@{ SkuId = $SkuId }); RemoveLicenses = @() }
    Set-MgUserLicense -UserId $user.Id -BodyParameter $body
    Write-Host "Lisens lagt til for $UserPrincipalName"
} else {
    $body = @{ AddLicenses = @(); RemoveLicenses = @($SkuId) }
    Set-MgUserLicense -UserId $user.Id -BodyParameter $body
    Write-Host "Lisens fjernet for $UserPrincipalName"
}
