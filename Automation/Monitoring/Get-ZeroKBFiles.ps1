# Path Config:
$Folder = 'C:\Folder-to-Monitor'
$LogPath = 'C:\Folder-Log'
$LogFile = "$LogPath\LogFile.txt"
$RemovedFiles = "$LogPath\Moved Files"

# Action for finding zero KB files:
$Action = Get-ChildItem -Path $Folder | Where-Object {$_.Length -eq 0 -and $_.Extension -eq '.pdf'}

# Email Config:
$Smtp = "smtp.mail.com"
$From = "Monitoring Service <monitoringservice@mail.com"
$To = "User Name <username@mail.com"
$Body = "A zero KB file was found here: $Folder. <br> The filename is: $Action. <br> The files and logs have been moved here: $LogFile and $RemovedFiles."
$Subject = "Zero KB Files Found"

# Create Log Directories 
If(Test-Path -Path $LogPath)
{
    Write-Host -ForegroundColor Green "$LogPath exists."
    } 
    Else 
    {
    New-Item -ItemType Directory -Path $LogPath
}

# Create 'Removed Files' directory
If(Test-Path -Path $RemovedFiles)
{
    Write-Host -ForegroundColor Green "$RemovedFiles exists."
    }
    Else
    {
    New-Item -ItemType Directory -Path $RemovedFiles
}

# Run it and output the filename to the log file if exists
    $Action | Select-Object CreationTime, Name |
        Format-Table -AutoSize | Out-File -Append $LogFile

# Wait 10 seconds and then query again to send an email
    Start-Sleep -Seconds 10

# Check and then send an email if the zero KB file exists
If($Action)
{
    Send-MailMessage -SmtpServer $Smtp -From $From -To $To -Subject $Subject -Body $Body -BodyAsHtml
    }
    Else
    {
    Start-Sleep -Seconds 10
}

# Move the zero KB file to 'Removed Files' directory
    $Action | Move-Item -Destination $RemovedFiles -Force 
