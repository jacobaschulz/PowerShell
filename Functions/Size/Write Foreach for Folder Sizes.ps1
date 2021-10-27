# Variables list
$Root = 'C:'
$GetAllFolders = Get-ChildItem -Path "$Root\" -Directory

# Uses a foreach loop for each folder and uses Write-Host for each path to output a list of paths
Foreach($Folder in $GetAllFolders) {
Write-Host "(Get-ChildItem -Path '$Root\$Folder' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB"
}

<# Sample Output:
-----------------

(Get-ChildItem -Path 'C:\agent' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB
(Get-ChildItem -Path 'C:\Deployed' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB

#>