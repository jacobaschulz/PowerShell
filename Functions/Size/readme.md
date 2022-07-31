## Write Foreach for Folder Sizes

### Usage: Run this to ouptut a set of commands for multiple subdirectories

#### Sample output:
``` powershell 
(Get-ChildItem -Path 'C:\agent' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB
(Get-ChildItem -Path 'C:\Deployed' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB
```

