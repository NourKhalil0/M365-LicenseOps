# Automatisk kjoring med Task Scheduler

For a kjore scriptsene automatisk (f.eks. ukentlig) kan du bruke Windows Task Scheduler.

## Eksempel: ukentlig lisensrapport

1. Apne Task Scheduler
2. Create Basic Task
3. Trigger: Weekly, velg dag og tidspunkt
4. Action: Start a program
   - Program: `powershell.exe`
   - Arguments: `-NonInteractive -File "C:\Scripts\Get-LicenseOverview.ps1"`

## Autentisering uten interaktiv innlogging

Scriptsene bruker `Connect-MgGraph` som normalt krever nettleser. For automatisk kjoring ma du bruke client credentials:

```powershell
$cred = [System.Net.NetworkCredential]::new("", (ConvertTo-SecureString "<secret>" -AsPlainText -Force))
Connect-MgGraph -TenantId "<tenant-id>" -ClientId "<client-id>" -ClientSecretCredential $cred.SecurePassword
```

Eller lagre hemmeligheten i Windows Credential Manager og hent den i scriptet.

## Logging

Legg til dette i starten av scriptet for a logge til fil:

```powershell
Start-Transcript -Path "C:\Logs\licenseops_$(Get-Date -Format 'yyyyMMdd').log" -Append
```
