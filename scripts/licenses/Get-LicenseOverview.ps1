Connect-MgGraph -Scopes "Organization.Read.All"

$skus = Get-MgSubscribedSku

foreach ($sku in $skus) {
    $total = $sku.PrepaidUnits.Enabled
    $used = $sku.ConsumedUnits
    $free = $total - $used

    [PSCustomObject]@{
        Lisens   = $sku.SkuPartNumber
        Totalt   = $total
        Brukt    = $used
        Ledig    = $free
    }
} | Format-Table -AutoSize
