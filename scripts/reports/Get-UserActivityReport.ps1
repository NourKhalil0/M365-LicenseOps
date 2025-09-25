Connect-MgGraph -Scopes "Reports.Read.All"

$days = 30
$report = Get-MgReportM365AppUserDetail -Period "D$days"

$csv = [System.Text.Encoding]::UTF8.GetString($report)
$rows = $csv | ConvertFrom-Csv

$result = foreach ($row in $rows) {
    [PSCustomObject]@{
        Bruker          = $row.'User Principal Name'
        SisteAktivitet  = $row.'Last Activity Date'
        Teams           = $row.'Microsoft Teams'
        Exchange        = $row.'Exchange'
        SharePoint      = $row.'SharePoint'
    }
}

$result | Sort-Object SisteAktivitet -Descending | Export-Csv -Path ".\brukeraktivitet_$(Get-Date -Format 'yyyyMMdd').csv" -NoTypeInformation -Encoding UTF8
Write-Host "Rapport lagret"
