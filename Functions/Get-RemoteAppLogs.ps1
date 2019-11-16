Function Get-RemoteAppLogs {
    param (
    [string] $Computer,
    [string] $Source,
    [int] $Entries
    )

    Get-EventLog -LogName Application -ComputerName $Computer -Source $Source -Newest $Entries
    }