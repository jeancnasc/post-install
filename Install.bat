@echo off
echo 'Instalando o PowerShell'
winget install "Microsoft.PowerShell" --accept-source-agreements --accept-package-agreements

pwsh -File %~dp0\Input.Fullname.ps1
pwsh -File %~dp0\Input.Email.ps1
pwsh -File %~dp0\Install.Terminal.ps1
pwsh -File %~dp0\Install.WSL.ps1
pwsh -File %~dp0\Install.Dev.ps1
pwsh -File %~dp0\Install.Dev.SSH.ps1

