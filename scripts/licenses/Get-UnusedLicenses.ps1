Connect-MgGraph -Scopes "User.Read.All", "AuditLog.Read.All"

$cutoff = (Get-Date).AddDays(-30)

$users = Get-MgUser -All -Property "DisplayName,UserPrincipalName,SignInActivity,AssignedLicenses" `
    -Filter "assignedLicenses/`$count ne 0" -CountVariable ignored -ConsistencyLevel eventual

$result = foreach ($user in $users) {
    $lastSignIn = $user.SignInActivity.LastSignInDateTime

    if ($null -eq $lastSignIn -or $lastSignIn -lt $cutoff) {
        [PSCustomObject]@{
            Navn            = $user.DisplayName
            UPN             = $user.UserPrincipalName
            SisteInnlogging = if ($lastSignIn) { $lastSignIn.ToString("dd.MM.yyyy") } else { "Aldri" }
        }
    }
}

$result | Sort-Object SisteInnlogging | Format-Table -AutoSize
Write-Host "$($result.Count) brukere flagget"
