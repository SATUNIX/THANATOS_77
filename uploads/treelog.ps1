# Gather IP configuration and related network information
$ipconfig = ipconfig /all
$iptables = Get-NetFirewallRule

# Save the information to pacman.txt
$ipconfig | Set-Content "pacman.txt"
Add-Content "pacman.txt" "`n`n`nFirewall Rules:`n`n"
$iptables | Out-String | Add-Content "pacman.txt"

# Upload pacman.txt to the local backup server
$localBackupServer = "http://10.1.1.1:8080/upload"
$filePath = Resolve-Path "pacman.txt"
Invoke-WebRequest -Uri $localBackupServer -Method Post -InFile $filePath -ContentType "multipart/form-data" -Form @{ file = Get-Item -Path $filePath }
