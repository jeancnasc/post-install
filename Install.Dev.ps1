$ErrorActionPreference = 'Stop'

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Instalando Visual Code'
winget install Microsoft.VisualStudioCode

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Instalando Git'
$infPath = Join-Path -Path $PSScriptRoot -ChildPath "Setup.Git.inf"
winget install Git.Git --custom /LOADINF=$infPath

& $PSScriptRoot/Input.Fullname.ps1
& $PSScriptRoot/Input.Email.ps1

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

git config --global user.name "$env:POST_INSTALL_FULLNAME"
git config --global user.email "$env:POST_INSTALL_EMAIL"