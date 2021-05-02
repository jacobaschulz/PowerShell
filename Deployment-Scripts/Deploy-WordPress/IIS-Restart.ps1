# Restart IIS

Stop-WebSite -Name "Default Web Site"

Start-WebSite -Name "Default Web Site"