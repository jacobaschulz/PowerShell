
# Varaible configurations
$filepath = "C:\database-config.xml"

# Create a function to modify the nodes in sections.section of the XML
Function Modify-SectionNodes {
Param (
    [string] $key,
    [string] $value
	)
	$file = "$filepath"
	$config = (Get-content -Path $file) -as [xml]
	$node = ($config.sections.section).ChildNodes # Gets the childnodes in sections.section of the XML
	$node_key = $node | where -Property key -EQ "$key" # Chooses the property "key" of the XML
	$node_key.value = "$value" # Changes the current value to a new value

	# Saves the config file after changes are made
	$config.Save($file)
	}

# Change the database value to a new value
Modify-SectionNodes -key "database" -value "new_database"

# Change the server value to a new value
Modify-SectionNodes -key "server" -value "localhost:8080"
