$ErrorActionPreference = 'Stop'

Write-Output 'Instalando o WSL'
wsl --install Ubuntu --no-launch
$checkPendingReboot = Start-Process -FilePath ubuntu -ArgumentList "run echo" -PassThru -Wait
$configScript = Join-Path -Path $PSScriptRoot -ChildPath ".\Install.WSL.Config.ps1"
if(($checkPendingReboot.ExitCode) -ne 0) {
    $taskTrigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
    $taskAction = New-ScheduledTaskAction `
        -Execute "cmd" `
        -Argument "/C pwsh -File $configScript"
        
    Unregister-ScheduledTask "WSL" -TaskPath "\Post-Install\" -Confirm:$false -ErrorAction Ignore | Out-Null
    Register-ScheduledTask "WSL" -TaskPath "\Post-Install\" -Action $taskAction -Trigger $taskTrigger -RunLevel Highest | Out-Null
} else {
    & $configScript
}
