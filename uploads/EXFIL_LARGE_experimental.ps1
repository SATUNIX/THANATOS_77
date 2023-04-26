$dir = Get-Location
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip_file = "directory.zip"
[System.IO.Compression.ZipFile]::CreateFromDirectory($dir, $zip_file, "Optimal", $false)
$url = "http://<flask_server_ip>:8000/upload"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("User-Agent", "PowerShell")
$headers.Add("Accept", "*/*")
$headers.Add("Content-Type", "multipart/form-data")
$response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -InFile $zip_file -ContentType "multipart/form-data"
Write-Host $response
