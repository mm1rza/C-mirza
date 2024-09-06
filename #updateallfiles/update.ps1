$localVersionFile = "C:\#mirza\#updateallfiles\version.txt"
$remoteVersionUrl = "https://raw.githubusercontent.com/mm1rza/C-mirza/main/%23updateallfiles/version.txt"

function Get-RemoteVersion {
    param ($url)
    $wc = New-Object net.webclient
    return $wc.DownloadString($url)
}

if (Test-Path $localVersionFile) {
    $localVersion = Get-Content $localVersionFile -Raw
    Write-Host "Versi di komputer saat ini : $localVersion"
} else {
    Write-Host "File tidak ditemukan."
    $localVersion = ""
}

$remoteVersion = Get-RemoteVersion $remoteVersionUrl
Write-Host "Versi di cloud : $remoteVersion"

if ($localVersion -eq $remoteVersion) {
    Write-Host "Versi sudah terbaru."
    $response = Read-Host "Apakah Anda ingin memaksa update? (Y/N)"
    if ($response -eq 'Y') {
        Write-Host "Memaksa update..."
    } else {
        Write-Host "Tidak ada update dilakukan."
        Read-Host "Tekan Enter untuk menutup jendela ini..."
        exit
    }
} else {
    Write-Host "Update tersedia."
}

# Mulai proses update
Write-Host "Update Tersedia. Mengupdate files..."

$folder = "C:\#mirza"
if (Test-Path $folder) {
    Write-Host "Menghapus folder dan subfolder: $folder"
    Remove-Item $folder -Recurse -Force
}

Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "
Write-Host " "

Clear-Host

$downloadUrl = "https://github.com/mm1rza/C-mirza/archive/refs/heads/main.zip"
$localPath = "C:\#mirza"
$zipFilePath = "C:\#mirza\C-mirza.zip"

if (-Not (Test-Path $localPath)) {
    New-Item -ItemType Directory -Path $localPath -Force
}
Write-Output "Download file dari $downloadUrl..."
$wc = New-Object net.webclient
$wc.DownloadFile($downloadUrl, $zipFilePath)
Write-Output "Extract file ke $localPath..."
Expand-Archive -Path $zipFilePath -DestinationPath $localPath -Force
Write-Output "Membersihkan file..."
Remove-Item $zipFilePath
Write-Output "Download and extract selesai."

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

$files = @("C:\#mirza\README.md", "C:\#mirza\.gitattributes")
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Menghapus file: $file"
        Remove-Item $file -Force
    }
}
Write-Host "Update selesai."
