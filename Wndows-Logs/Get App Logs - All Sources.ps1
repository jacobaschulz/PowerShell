Import-Module "C:\Users\$env:username\GitHub\Powershell-Scripts\Functions\Get-RemoteAppLogs.ps1"

# Number of logs to get
$NumLogs = 15

Get-RemoteLogs -Computer $env:COMPUTERNAME -Source * -Entries $NumLogs