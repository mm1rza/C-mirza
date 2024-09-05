# Variables
$localVersionFile = "C:\#mirza\#updateallfiles\version.txt"
$remoteVersionUrl = "https://raw.githubusercontent.com/mm1rza/C-mirza/main/%23updateallfiles/version.txt"

# Function to download remote version file content
function Get-RemoteVersion {
    param ($url)
    $wc = New-Object net.webclient
    return $wc.DownloadString($url)
}

# Check if local version file exists
if (Test-Path $localVersionFile) {
    $localVersion = Get-Content $localVersionFile -Raw
    Write-Host "Local version: $localVersion"
} else {
    Write-Host "Local version file not found."
    $localVersion = ""
}

# Get remote version
$remoteVersion = Get-RemoteVersion $remoteVersionUrl
Write-Host "Remote version: $remoteVersion"

# Compare versions
if ($localVersion -eq $remoteVersion) {
    Write-Host "No update needed. Local version is up-to-date."
} else {
    Write-Host "New version found. Updating..."
    
    # Proceed with your existing download, extraction, and file-moving logic
    $downloadUrl = "https://github.com/mm1rza/C-mirza/archive/refs/heads/main.zip"
    $localPath = "C:\#mirza"
    $zipFilePath = "C:\#mirza\C-mirza.zip"

    if (-Not (Test-Path $localPath)) {
        New-Item -ItemType Directory -Path $localPath -Force
    }
    Write-Output "Downloading file from $downloadUrl..."
    $wc = New-Object net.webclient
    $wc.DownloadFile($downloadUrl, $zipFilePath)
    Write-Output "Extracting file to $localPath..."
    Expand-Archive -Path $zipFilePath -DestinationPath $localPath -Force
    Write-Output "Cleaning up..."
    Remove-Item $zipFilePath
    Write-Output "Download and extraction complete."

    $sumber = "C:\#mirza\C-mirza-main"
    $tujuan = "C:\#mirza"
    if (-not (Test-Path -Path $tujuan)) {
        Write-Host "Folder tujuan tidak ada. Membuat folder tujuan..."
        New-Item -Path $tujuan -ItemType Directory
    } else {
        Write-Host "Folder tujuan sudah ada."
    }
    Write-Host "Memindahkan file dan folder dari $sumber ke $tujuan..."
    Get-ChildItem -Path $sumber -Recurse | ForEach-Object {
        $targetPath = Join-Path -Path $tujuan -ChildPath $_.FullName.Substring($sumber.Length)
        if ($_.PSIsContainer) {
            if (-not (Test-Path -Path $targetPath)) {
                Write-Host "Membuat folder: $targetPath"
                New-Item -Path $targetPath -ItemType Directory
            }
        } else {
            Write-Host "Memindahkan file: $_.FullName ke $targetPath"
            Move-Item -Path $_.FullName -Destination $targetPath -Force
        }
    }
    Write-Host "Menghapus folder sumber..."
    Remove-Item -Path $sumber -Recurse -Force

    Write-Host "Update complete."
}
