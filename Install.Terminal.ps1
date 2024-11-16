$ErrorActionPreference = 'Stop'

$postInstallHome = $env:POST_INSTALL_HOME ?? $env:OneDrive
$configPath = Join-Path -Path $postInstallHome -ChildPath Config
Write-Output "Pasta de Configuração: $configPath"
if(!(Test-Path -PathType Container -Path $configPath)){
    New-Item -Type Directory $configPath | Out-Null
}

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Instalando Windows Terminal'
winget install 'Microsoft.WindowsTerminal'

$configPathWinTerm = Join-Path -Path $configPath -ChildPath "WindowsTerminal" 
$settingsPathOriginal = Join-Path -Path $env:LOCALAPPDATA -ChildPath "\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$settingsPathConfig = Join-Path -Path $configPathWinTerm -ChildPath "settings.json" 

If(!(Test-Path -PathType Leaf -Path $settingsPathConfig)){
    New-Item -ItemType Directory -Path $configPathWinTerm | Out-Null
    Copy-Item -Path $settingsPathOriginal -Destination $settingsPathConfig -Force | Out-Null
}
New-Item -ItemType SymbolicLink -Path $settingsPathOriginal -Target $settingsPathConfig -Force | Out-Null

# Configurar como terminal padrão

$RegPath = "HKCU:\Console\%%Startup"
New-Item -Path $RegPath -Force | Out-Null
New-ItemProperty -Path $RegPath -Name 'DelegationConsole' -Value '{2EACA947-7F5F-4CFA-BA87-8F7FBEEFBE69}' -PropertyType String -Force | Out-Null
New-ItemProperty -Path $RegPath -Name 'DelegationTerminal' -Value '{E12CFF52-A866-4C77-9A90-F570A7AA2C6B}' -PropertyType String -Force | Out-Null

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Instalando o Clink'
winget install 'chrisant996.Clink'

$configPathClink = Join-Path -Path $configPath -ChildPath "Clink" 

If(!(Test-Path -PathType Container -Path $configPathClink)){
    New-Item -ItemType Directory -Path "$configPathClink" | Out-Null
}
[Environment]::SetEnvironmentVariable('CLINK_SETTINGS', $configPathClink, 'User')
[Environment]::SetEnvironmentVariable('CLINK_PATH', $configPathClink, 'User')

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Instalando Oh My Posh'
winget install 'JanDeDobbeleer.OhMyPosh'



$configPathPOSH = Join-Path -Path $configPath -ChildPath "OhMyPosh" 

$env:POSH_THEMES_PATH = [System.Environment]::GetEnvironmentVariable("POSH_THEMES_PATH","User") 
$defaultPoshTheme = Join-Path -Path $env:POSH_THEMES_PATH -ChildPath "jandedobbeleer.omp.json"
$poshTheme = Join-Path -Path $configPathPOSH -ChildPath "theme.omp.json"

If(!(Test-Path -PathType Container -Path $configPathPOSH)){
    New-Item -ItemType Directory -Path "$configPathPOSH" | Out-Null
    Copy-Item -Path $defaultPoshTheme -Destination $poshTheme -Force | Out-Null
}

# Integrar com PowerShell

if(!(Test-Path -PathType Leaf -Path $PROFILE)){
    New-Item -Path $PROFILE -Force | Out-Null
}
@("if (Get-Command oh-my-posh -ErrorAction SilentlyContinue){ oh-my-posh init pwsh --config `"$poshTheme`" | Invoke-Expression }") + $(Get-Content -Force $PROFILE | Select-String oh-my-posh -NotMatch) | Set-Content $PROFILE

# Integrar com Clink

$poshClinkScript = Join-Path -Path $configPathClink -ChildPath "oh-my-posh.lua"
"if( os.execute('where /Q oh-my-posh') ) then load(io.popen('oh-my-posh init cmd --config `"$($poshTheme -replace '\\', '/')`" '):read(`"*a`"))() end" | Set-Content $poshClinkScript

# Instalar Fontes

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
oh-my-posh font install cascadiamono
