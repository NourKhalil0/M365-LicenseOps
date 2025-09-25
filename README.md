# M365-LicenseOps

PowerShell-scripts for å administrere Microsoft 365-lisenser og Entra ID-sync.

Dekker lisensovervisning, brukeropprydding, synkroniseringsstatus og kostnadsrapporter.

## Krav

- PowerShell 5.1 eller nyere
- Microsoft Graph PowerShell SDK: `Install-Module Microsoft.Graph`
- Tilstrekkelige Graph-tillatelser (se docs/setup.md)

## Bruk

```powershell
# Lisensovervisning
.\scripts\licenses\Get-LicenseOverview.ps1

# Finn brukere som ikke har logget inn siste 30 dager
.\scripts\licenses\Get-UnusedLicenses.ps1

# Sjekk AD-sync
.\scripts\entra\Get-SyncStatus.ps1
```
