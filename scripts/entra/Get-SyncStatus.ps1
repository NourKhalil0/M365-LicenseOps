Connect-MgGraph -Scopes "Organization.Read.All"

$org = Get-MgOrganization

$sync = $org.OnPremisesSyncEnabled
$lastSync = $org.OnPremisesLastSyncDateTime
$errors = $org.OnPremisesProvisioningErrors

Write-Host "Sync aktivert: $sync"
Write-Host "Siste sync:    $(if ($lastSync) { $lastSync.ToString('dd.MM.yyyy HH:mm') } else { 'ukjent' })"

if ($lastSync -and $lastSync -lt (Get-Date).AddHours(-3)) {
    Write-Warning "Sync er mer enn 3 timer gammel"
}

if ($errors.Count -gt 0) {
    Write-Warning "$($errors.Count) synkroniseringsfeil funnet - kjor Get-SyncErrors.ps1"
} else {
    Write-Host "Ingen feil registrert"
}
