# Clean WebRoot file path
$Dest = "$(WebRoot)\*" # Azure DevOps variable for the root path of the web app in IIS

Remove-item -Path $Dest -Recurse -Force