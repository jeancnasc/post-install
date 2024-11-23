@echo off
echo 'Instalando o PowerShell'
winget install "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements

pwsh -File %~dp0\Install.Terminal.ps1
pwsh -File %~dp0\Install.WSL.ps1
