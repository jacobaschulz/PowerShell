# Path Config:
$Folder = 'C:\Folder-to-Monitor'

# Email Config:
$Smtp = "smtp.mail.com"
$From = "Monitoring Service <monitoringservice@mail.com"
$To = "User Name <username@mail.com"
$Body = "An old file was found here: $Folder. <br> The file might be open on a user's desktop."
$Subject = "Old File Found"

# Function Config:
Function Get-OldFiles

{Param(
    [string] $Path,
    [int] $NumberMins
    )

$CutoffDate = (Get-Date).AddMinutes(-$NumberMins)

Get-ChildItem -Path $Path -Exclude *Temp* |
    Where-Object {$_.LastAccessTime -le $CutoffDate}
}

# If/else that sends an email if the old file is found after 15 mintues
If(Get-OldFiles -Path $Folder -NumberMins 15 -eq $true)
{
    Send-MailMessage -SmtpServer $Smtp -From $From -To $To -Subject $Subject -Body $Body -BodyAsHtml
    }
    else
{
    Start-Sleep -Seconds 10
    }



