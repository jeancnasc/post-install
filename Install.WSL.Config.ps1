$ErrorActionPreference = 'Stop'

$postInstallHome = $env:POST_INSTALL_HOME ?? $env:OneDrive
$configPath = Join-Path -Path $postInstallHome -ChildPath Config

# --------------------------------------------------------------------------------------------------------------
# Configurar o WSL

wsl --set-default Ubuntu
wsl --user root -- adduser wsluser --gecos `"`"
wsl --user root -- usermod -aG sudo wsluser
wsl --manage Ubuntu --set-default-user wsluser
wsl --user root -- apt update `&`& apt upgrade -y

# --------------------------------------------------------------------------------------------------------------
# Instalar o Oh My Posh

wsl --user root -- apt install unzip
wsl -- curl -s https://ohmyposh.dev/install.sh `| bash -s

$configPathPOSH = Join-Path -Path $configPath -ChildPath "OhMyPosh" 
$poshTheme = Join-Path -Path $configPathPOSH -ChildPath "theme.omp.json"

$poshThemeWsl = wsl wslpath "$($poshTheme -replace '\\','\\')"

$time = Get-Date -Format "yyyyMMddHHmmss"
wsl -- cp ~/.profile ~/.profile.$time.bak 
wsl -- cat ~/.profile.$time.bak `| grep --invert-match oh-my-posh `> ~/.profile 
wsl -- echo "eval `"\`$(oh-my-posh init bash --config `"$poshThemeWsl`" )`"" `>> ~/.profile

# --------------------------------------------------------------------------------------------------------------
# Remover Tarefa

Unregister-ScheduledTask "WSL" -TaskPath "\Post-Install\" -Confirm:$false -ErrorAction Ignore | Out-Null