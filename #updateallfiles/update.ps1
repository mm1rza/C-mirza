# Check if PowerShell is running as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "WARNING: This script is not running with administrator privileges." -ForegroundColor Red -BackgroundColor Black
    Write-Host "Please run PowerShell / CMD as Administrator and try again." -ForegroundColor Red -BackgroundColor Black
	Write-Host "" -ForegroundColor Red
	Write-Host "Jalankan kan ulang PowerShell / CMD" -ForegroundColor Green -BackgroundColor Black
	Write-Host "Run As ADMINISTRATOR ( PowerShell / CMD )" -ForegroundColor Green -BackgroundColor Black
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

# Tentukan jalur sumber dan tujuan
$sumber = "C:\#mirza\C-mirza-main"
$tujuan = "C:\#mirza"

# Cek apakah folder tujuan ada, jika tidak, buat folder tersebut
if (-not (Test-Path -Path $tujuan)) {
    Write-Host "Folder tujuan tidak ada. Membuat folder tujuan..."
    New-Item -Path $tujuan -ItemType Directory
} else {
    Write-Host "Folder tujuan sudah ada."
}

# Pindahkan semua file dan folder dari sumber ke tujuan
Write-Host "Memindahkan file dan folder dari $sumber ke $tujuan..."
Get-ChildItem -Path $sumber -Recurse | ForEach-Object {
    $targetPath = Join-Path -Path $tujuan -ChildPath $_.FullName.Substring($sumber.Length)
    if ($_.PSIsContainer) {
        # Buat folder di tujuan jika belum ada
        if (-not (Test-Path -Path $targetPath)) {
            Write-Host "Membuat folder: $targetPath"
            New-Item -Path $targetPath -ItemType Directory
        }
    } else {
        # Pindahkan file
        Write-Host "Memindahkan file: $_.FullName ke $targetPath"
        Move-Item -Path $_.FullName -Destination $targetPath -Force
    }
}

# Hapus folder sumber setelah pemindahan selesai
Write-Host "Menghapus folder sumber..."
Remove-Item -Path $sumber -Recurse -Force


exit
exit

}
