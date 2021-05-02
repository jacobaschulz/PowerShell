# Copies web files to webroot directory
$DeployLoc = "C:\Deployed\Websites\$(Build.DefinitionName)_$(Build.BuildId)\wordpress-root\*"
$Dest = "$(WebRoot)" # Root directory of where the web app points to in IIS

Copy-Item -Path $DeployLoc -Destination $Dest -Force -Recurse