# Oppsett

## Installer Microsoft Graph SDK

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
```

## Tillatelser som trengs

Scriptet bruker ulike Graph-scopes avhengig av hva du kjorer. Ved forste kjoring vil PowerShell be om samtykke i nettleseren.

- Lisensscripts: `Organization.Read.All`, `User.ReadWrite.All`, `AuditLog.Read.All`
- Entra-scripts: `Organization.Read.All`
- Rapporter: `Reports.Read.All`

For automatisk kjoring (uten interaktiv innlogging) ma du sette opp en app-registrering i Entra ID med client credentials. Se scheduled-tasks.md.

## App-registrering

1. Ga til Entra ID > App registrations > New registration
2. Gi appen et navn, f.eks. `LicenseOps-Script`
3. Under "API permissions", legg til Graph-tillatelsene ovenfor som Application permissions
4. Generer en client secret under "Certificates & secrets"
5. Logg inn i scriptet med:

```powershell
Connect-MgGraph -TenantId "<tenant-id>" -ClientId "<client-id>" -ClientSecret "<secret>"
```
