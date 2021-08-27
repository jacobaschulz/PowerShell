$Import = 'C:\Users\jacob\Documents\Web-Split-File-Test\Import'
$Final = 'C:\Users\jacob\Documents\Web-Split-File-Test\Final'
$SubImport = get-childitem $Import\*
$Extension = ''

# Create folders if they don't exist
If((Test-Path $Import) -eq $false) {
    New-Item -Path $Import -ItemType Directory}
    Else {
    Write-Host -ForegroundColor Yellow "$Import exists."
    }

If((Test-Path $Final) -eq $false) {
    New-Item -Path "$Final" -ItemType Directory}
    Else {
    Write-Host -ForegroundColor Yellow "$Final exists."
    }

# Append timestamp to each filename for unique values
Foreach($Subfolder in $SubImport) {
    Get-ChildItem -Path $Subfolder -Recurse -File | Where-Object {$_.Extension -eq $Extension} |
        Rename-Item -NewName {$_.BaseName + "-" + (Get-Date -Format "yyyyMMdd-HHmmssffff") + $_.Extension}
        } 

# Move files out to parent
Foreach($Subfolder in $SubImport) {
    Get-ChildItem -Path $Subfolder -Recurse -File | Where-Object {$_.Extension -eq $Extension} |
        Move-Item -Destination $Subfolder -ErrorAction SilentlyContinue
        }

# Delete empty folders
Foreach($Subfolder in $SubImport) {
    Get-ChildItem -Path $Subfolder -Recurse -Directory -Exclude *.* | Remove-Item -Recurse 
    }

# Folder Reorganization script based on number of files per folder
$FilesPerFolder = 2
$inc = 0;
$FolderNumber = 1;

Foreach($Subfolder in $SubImport) {
    Get-ChildItem -Path "$Subfolder\*" | Where-Object {$_.Extension -eq $Extension} |
    Foreach {

    New-Item -Path "$Subfolder\Reorganized-Files-$FolderNumber" -ItemType Directory -Force | Out-Null
    Move-Item -Path $_ "$Subfolder\Reorganized-Files-$FolderNumber" -Force;

    $inc++;

    if($inc -eq $FilesPerFolder){
        $FolderNumber++;
        $inc = 0;
        }
    }
}

# Move reorganized folders
Foreach($Subfolder in $SubImport) {
    If(
    Get-ChildItem -Path $Subfolder -Recurse -Directory | Where-Object {$_.Name -match "Reorganized-Files"}) {
        Move-Item -Destination $Final -Path $Subfolder}
        Else {
        Start-Sleep -Seconds 5
        }
    }
