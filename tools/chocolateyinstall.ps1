$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\helper.ps1"

$url        = 'https://github.com/EslaMx7/PasteIntoFile/releases/download/v1.5/PasteIntoFile.zip'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  checksum      = '76D94F5A930CA70198723FC66E639618840347F4FB1DFD9972637EDBC42AE867'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

# silent install requires AutoHotKey
$ahkProc = Start-Ahk('captureWindow.ahk')

& "$toolsDir\PasteIntoFile.exe" /reg
# minimum delay to ensure the autohotkey takes efect
& Start-Sleep 1

if (Get-Process -id $ahkProc.Id -ErrorAction SilentlyContinue) {Stop-Process -id $ahkProc.Id}
