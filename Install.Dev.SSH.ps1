$postInstallHome = $env:POST_INSTALL_HOME ?? $env:OneDrive
$configPath = Join-Path -Path $postInstallHome -ChildPath Config

# --------------------------------------------------------------------------------------------------------------

Write-Output 'Configurando SSH'
& $PSScriptRoot/Input.Email.ps1

$sshOriginalPath = Join-Path -Path $env:USERPROFILE -ChildPath ".ssh"
$sshConfigPath = Join-Path -Path $configPath -ChildPath "SSH"


if(Test-Path -Type Container -Path $sshConfigPath){
    if((Test-Path -Type Container -Path $sshOriginalPath) -and ($null -eq (Get-Item $sshOriginalPath ).LinkType)){
        $time = Get-Date -Format "yyyyMMddHHmmss"
        Move-Item $sshOriginalPath "$sshOriginalPath.$time.bak" | Out-Null
    }
} else {
    if(Test-Path -Type Container -Path $sshOriginalPath){
        Move-Item $sshOriginalPath $sshConfigPath | Out-Null
    } else{
        New-Item -ItemType Directory $sshConfigPath | Out-Null
    }
}
New-Item -ItemType SymbolicLink -Path $sshOriginalPath -Target $sshConfigPath -Force | Out-Null

$keyPath = Join-Path -Path $sshOriginalPath -ChildPath "id_rsa"
if(!(Test-Path -PathType Leaf $keyPath)){
    Write-Host "Gerando Chave para $env:POST_INSTALL_EMAIL"
    "y" | ssh-keygen -t ed25519 -C $env:POST_INSTALL_EMAIL -N "" -f $keyPath
}