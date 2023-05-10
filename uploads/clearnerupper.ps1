
# Wait for 5 minutes (300 seconds)
Start-Sleep -Seconds 600

# Delete the specified files
Remove-Item -Path "persistence.bat" -ErrorAction Ignore
Remove-Item -Path "nc.bin" -ErrorAction Ignore
Remove-Item -Path "treelog.ps1" -ErrorAction Ignore
Remove-Item -Path "cleanerupper.ps1" -ErrorAction Ignore
Remove-Item -Path "pacman5.ps1" -ErrorAction Ignore

Start-Sleep -Seconds 300
reboot
