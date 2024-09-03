# Define URL and local path
$downloadUrl = "https://github.com/mm1rza/C-mirza/archive/refs/heads/main.zip"
$localPath = "C:\#mirza"
$zipFilePath = "$localPath\C-mirza.zip"

# Create local directory if it doesn't exist
if (-Not (Test-Path $localPath)) {
    New-Item -ItemType Directory -Path $localPath -Force
}

# Download the zip file
Write-Output "Downloading file from $downloadUrl..."
Invoke-WebRequest -Uri $downloadUrl -OutFile $zipFilePath

# Extract the zip file, replacing any existing files
Write-Output "Extracting file to $localPath..."
Expand-Archive -Path $zipFilePath -DestinationPath $localPath -Force

# Clean up by removing the zip file
Write-Output "Cleaning up..."
Remove-Item $zipFilePath

Write-Output "Download and extraction complete."

exit