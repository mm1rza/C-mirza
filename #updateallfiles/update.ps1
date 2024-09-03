# Check if PowerShell is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "WARNING: This script is not running with administrator privileges." -ForegroundColor Red -BackgroundColor Black
    Write-Host "Please run PowerShell as Administrator and try again." -ForegroundColor Red -BackgroundColor Black
	Write-Host "" -ForegroundColor Red
	Write-Host "Jalankan kan ulang PowerShell" -ForegroundColor Green -BackgroundColor Black
	Write-Host "Run As ADMINISTRATOR ( PowerShell )" -ForegroundColor Green -BackgroundColor Black
}
else {
    # Define URL and local path
    $downloadUrl = "https://github.com/mm1rza/C-mirza/archive/refs/heads/main.zip"
    $localPath = "C:\#mirza"
    $zipFilePath = "C:\#mirza\C-mirza.zip"

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
	exit
}
