# Checks the WebRoot and creates if it doesn't exist
# Script used with Azure DevOps due to $(variables)
$WebRootCheck = Test-Path -Path $(WebRoot)
If($WebRootCheck -eq $false) {
    New-Item -Path $(WebRoot) -ItemType directory 
    }
else {
Write-Host "$(WebRoot) path already exists."
}