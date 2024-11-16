@echo off
echo 'Instalando o PowerShell'
winget install "Microsoft.PowerShell"

pwsh -File %~dp0\Install.Terminal.ps1