param(
    [string]$PrisfilPath = ".\templates\license-audit-template.csv"
)

Connect-MgGraph -Scopes "Organization.Read.All", "User.Read.All"

$priser = Import-Csv -Path $PrisfilPath -Delimiter ";"

$skus = Get-MgSubscribedSku

$result = foreach ($sku in $skus) {
    $pris = ($priser | Where-Object { $_.SkuPartNumber -eq $sku.SkuPartNumber }).MndPrisNOK

    [PSCustomObject]@{
        Lisens       = $sku.SkuPartNumber
        Brukt        = $sku.ConsumedUnits
        PrisPerBruker = if ($pris) { [decimal]$pris } else { 0 }
        MndTotal     = if ($pris) { $sku.ConsumedUnits * [decimal]$pris } else { 0 }
    }
}

$result | Format-Table -AutoSize
Write-Host ("Estimert total per maned: {0} NOK" -f ($result | Measure-Object MndTotal -Sum).Sum)
