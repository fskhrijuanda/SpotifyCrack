;;;===,,,@echo off
;;;===,,,color 0a
;;;===,,,findstr /v "^;;;===,,," "%~f0" > "%~dp0ps.ps1"
;;;===,,,PowerShell.exe -ExecutionPolicy Bypass -Command "& '%~dp0ps.ps1'"
;;;===,,,del /s /q "%~dp0ps.ps1" >NUL 2>&1
;;;===,,,pause
;;;===,,,exit
# Ignore errors from `Stop-Process`
$PSDefaultParameterValues['Stop-Process:ErrorAction'] = 'SilentlyContinue'

write-host @'
***************** 
Create By Fakhri
Follow Me: https://www.instagram.com/riririfak/
           https://github.com/fskhrijuanda
Made with LOVE  
***************** 
'@

$SpotifyDirectory = "$env:APPDATA\Spotify"
$SpotifyExecutable = "$SpotifyDirectory\Spotify.exe"
$SpotifyApps = "$SpotifyDirectory\Apps"

Write-Host 'Stopping Spotify...'`n
Stop-Process -Name Spotify
Stop-Process -Name SpotifyWebHelper

if (Get-AppxPackage -Name SpotifyAB.SpotifyMusic) {
  Write-Host @'
Spotify Microsoft Gk Support Ngab, Ganti ae Yang di website resmi nya Spotify.
'@`n
  $ch = Read-Host -Prompt "Hapus Spotify Windows Store edition (JAWAB AJA Y) "
  if ($ch -eq 'y'){
     Write-Host @'
Sedang Menghapus Spotify Windows Store edition, Sabar Ya.
'@`n
     Get-AppxPackage -Name SpotifyAB.SpotifyMusic | Remove-AppxPackage
  } else{
     Write-Host @'
Exiting...
'@`n
     Pause 
     exit
    }
}

Push-Location -LiteralPath $env:TEMP
try {
  # Unique directory name based on time
  New-Item -Type Directory -Name "SpotifyCrackFakhri-$(Get-Date -UFormat '%Y-%m-%d_%H-%M-%S')" `
  | Convert-Path `
  | Set-Location
} catch {
  Write-Output $_
  Pause
  exit
}

Write-Host 'Downloading latest patch (chrome_elf.zip)...'`n
$webClient = New-Object -TypeName System.Net.WebClient
try {
  $webClient.DownloadFile(
    # Remote file URL
    'https://github.com/fskhrijuanda/chrome_elf/releases/download/0.1/chrome_elf.zip',
    # Local file path
    "$PWD\chrome_elf.zip"
  )
} catch {
  Write-Output $_
  Sleep
}

Expand-Archive -Force -LiteralPath "$PWD\chrome_elf.zip" -DestinationPath $PWD
Remove-Item -LiteralPath "$PWD\chrome_elf.zip"

$spotifyInstalled = (Test-Path -LiteralPath $SpotifyExecutable)
if (-not $spotifyInstalled) {
  Write-Host @'
Spotify Tidak ada.
Sedang Mendownload Spotify Versi Terbaru Mohon Bersabar...
'@
  try {
    $webClient.DownloadFile(
      # Remote file URL
      'https://download.scdn.co/SpotifyFullSetup.exe',
      # Local file path
      "$PWD\SpotifyFullSetup.exe"
    )
  } catch {
    Write-Output $_
    Pause
    exit
  }
  mkdir $SpotifyDirectory >$null 2>&1
  Write-Host 'Running installation...'
  Start-Process -FilePath "$PWD\SpotifyFullSetup.exe"
  Write-Host 'keluarkan spotify...Lagi'
  while ((Get-Process -name Spotify -ErrorAction SilentlyContinue) -eq $null){
     #waiting until installation complete
     }
  Stop-Process -Name Spotify >$null 2>&1
  Stop-Process -Name SpotifyWebHelper >$null 2>&1
  Stop-Process -Name SpotifyFullSetup >$null 2>&1
}

if (!(test-path $SpotifyDirectory/chrome_elf.dll.bak)){
	move $SpotifyDirectory\chrome_elf.dll $SpotifyDirectory\chrome_elf.dll.bak >$null 2>&1
}

Write-Host 'Patching Spotify...'
$patchFiles = "$PWD\chrome_elf.dll", "$PWD\config.ini"

Copy-Item -LiteralPath $patchFiles -Destination "$SpotifyDirectory"


$ch = Read-Host -Prompt "Tekan Enter Kalau Sudah Selesai"
if ($ch -eq 'y'){
  start 
    Write-Host @' 
Gk bisa? Coba beli premium
'@`n
} else{
     Write-Host @'
Gk Bisa? Coba Upgrade Premium.

BTW MAKASIH UDH PAKE CODE GW YANG AMPAS INI
'@`n
}

$tempDirectory = $PWD
Pop-Location

Remove-Item -Recurse -LiteralPath $tempDirectory  

Write-Host 'Crack Sudah Selesai, Jalankan Spotify...'
Start-Process -WorkingDirectory $SpotifyDirectory -FilePath $SpotifyExecutable
Write-Host 'Done.'

start https://www.instagram.com/riririfak/
start https://github.com/fskhrijuanda

exit