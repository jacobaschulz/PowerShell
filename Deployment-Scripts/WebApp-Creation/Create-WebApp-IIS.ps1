# Creates a New WebApp in IIS
# Script used with Azure DevOps due to $(variables)
$WebAppCheck = Get-WebApplication -Site 'Default Web Site' -name "$(WebApp)"
if($WebAppCheck -ne $true) {
New-WebApplication -Name "$(WebApp)" -Site 'Default Web Site' -PhysicalPath "C:\Websites\$(WebApp)" -ApplicationPool DefaultAppPool -Force
} else {
Write-Host "$(WebApp) already exists."
}