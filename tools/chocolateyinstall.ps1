$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\helper.ps1"

$url        = 'https://github.com/EslaMx7/PasteIntoFile/releases/download/v1.4/PasteIntoFile.zip'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'pasteintofile*'
  checksum      = '7A39640CBA56030816BF3A62E612755A8DB166BFA52383E00042B741D060F499'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# silent install requires AutoHotKey
$ahkProc = Start-Ahk('captureWindow.ahk')

& "$toolsDir\PasteIntoFile.exe" /reg
# minimum delay to ensure the autohotkey takes efect
& Start-Sleep 1

if (Get-Process -id $ahkProc.Id -ErrorAction SilentlyContinue) {Stop-Process -id $ahkProc.Id}
