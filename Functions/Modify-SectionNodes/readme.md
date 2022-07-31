## Modify Section Nodes Function ##

## 1. Import Module
``` powershell
# Import the module into your session
Import-Module 'C:\Path-to-Modify-SectionNodes.ps1'
```
## 2. Modify the nodes in the .xml
``` powershell
# Example - Change the database value to a new value - # need to add config file path
Modify-SectionNodes -key "database" -value "new_database"

# Example - Change the server value to a new value - # need to add config file path 
Modify-SectionNodes -key "server" -value "localhost:8080"
```