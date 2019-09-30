# This function can be used to remove files older than X days from remote computers.
# It allows you to specify the days, servername and username.
# This can be run from one machine and target multiple remote machines.

# Function Config
Function Remove-OldItems

{Param(
    [string] $Server,
    [string] $User,
    [int] $Days
    )
$TimeFrame = (Get-Date).AddDays(-$Days)

Get-ChildItem -Path "\\$Server\C$\Users\$User\Temp" -Recurse |
    Where-Object{$_.LastWriteTime -le $TimeFrame} | Remove-Item -Force
}

# Specify the server name, user and number of days and this function will delete those files older than specified days
# Remove old files from DEVFILE01 server - TempUser account
	Remove-OldItems -Server DEVFILE01 -User TempUser -Days 4

# Remove old files from DEVFILE02 server - TempUser2 account
	Remove-OldItems -Server DEVFILE02 -User TempUser2 -Days 5

        

