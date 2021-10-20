# Folder path variables
$TempDir = "$env:USERPROFILE\Documents\Test Folder\Temp"
$ImportDir = "$env:USERPROFILE\Documents\Test Folder\Import"
$FinalDir = "$env:USERPROFILE\Documents\Test Folder\Final"

# Creates 20 new text files with the GUID as filename
for($i = 1; $i -le 20; $i++) {
$Guid = (New-Guid)
New-Item -Path "$TempDir\$Guid.txt"
}

# Copies some from the temp folder to the Final folder to do the comparison
Get-ChildItem -Path $TempDir | Select-Object -Last 10 | Copy-Item -Destination $FinalDir

#Get a list of the ones to be moved
$AllGuids = Get-ChildItem -Path $TempDir

# Performs a match based on the names of the ones in the Temp folder vs. what's in the Final folder
Foreach($Id in $AllGuids) {
$GuidMatch = ($Id.Name)
$GuidMatching = Get-ChildItem -Path $FinalDir |
    Where-Object {$_.Name -eq $GuidMatch}

# If a match isn't found, it moves it to the Final folder, else it will write an output saying that the file already exists
If($GuidMatching) {
    Write-Host -ForegroundColor Green "$ID already exists in $FinalDir."}
    else {
    Move-Item -Path $ID.FullName -Destination $FinalDir
    }
}