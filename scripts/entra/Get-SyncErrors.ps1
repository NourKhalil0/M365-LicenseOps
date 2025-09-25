Connect-MgGraph -Scopes "Organization.Read.All"

$org = Get-MgOrganization
$errors = $org.OnPremisesProvisioningErrors

if ($errors.Count -eq 0) {
    Write-Host "Ingen synkroniseringsfeil"
    return
}

foreach ($err in $errors) {
    [PSCustomObject]@{
        Kategori   = $err.Category
        Egenskap   = $err.PropertyCausingError
        Verdi      = $err.Value
        Oppstatt   = $err.OccurredDateTime.ToString("dd.MM.yyyy HH:mm")
    }
} | Format-Table -AutoSize
