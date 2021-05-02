<#  Notes:
    - $(prefix) is an Azure DevOps variable used to append the WebApp/Website name to the database table names. Passses in $(WebApp-Name)
    - $(WebApp-Name) is the name of the Web app that shows in IIS.
    - Azure DevOps variables for database connection settings:
        - $(DB_HOST) - target server/host name for database
        - $(DB_NAME) - target database name
        - $(DB_PASSWORD) - target database user password
        - $(DB_USER) - target database user name
#>

# Default Config Values
    $Def_DB = "database_name_here"
    $Def_User = "username_here"
    $Def_Password = "password_here"
    $Def_Host = "localhost"
    $table_prefix = "wp_prefix"
    $AppConfigPath = "$(WebRoot)"+"wp-config.php"
    $prefix_output = "wp_"+"$(prefix)" # Uses Azure DevOps variable for $(prefix), which is the $(WebApp-Name). The $(WebApp-Name) variable is the web app and is used when creating the Web 

# Creates a function to modify the config file.
Function Modify-PhpConfig {
    Param(
    [string] $DefVal,
    [string] $InputVal
    )

    ((Get-Content -Path $AppConfigPath -Raw).Replace("$DefVal", "$InputVal")) |
     Set-Content -Path $AppConfigPath 
}

# Configure DB Values
    Modify-PhpConfig -DefVal $Def_DB -InputVal "$(DB_NAME)"

    Modify-PhpConfig -DefVal $Def_User -InputVal "$(DB_USER)"

    Modify-PhpConfig -DefVal $Def_Password -InputVal "$(DB_PASSWORD)"

    Modify-PhpConfig -DefVal $Def_Host -InputVal "$(DB_HOST)"

    Modify-PhpConfig -DefVal $table_prefix -InputVal "$prefix_output"