$ErrorActionPreference = 'Stop'

Write-Output 'Instalando o WSL'
wsl --install Ubuntu --no-launch
$checkPendingReboot = Start-Process -FilePath wsl -ArgumentList "-- echo" -PassThru -Wait
if(($checkPendingReboot.ExitCode) -ne 0) {
    $installScript = Join-Path -Path $PSScriptRoot -ChildPath ".\Install.WSL.ps1"
    $taskTrigger = New-ScheduledTaskTrigger -AtLogOn -User $env:USERNAME
    $taskAction = New-ScheduledTaskAction `
        -Execute "cmd" `
        -Argument "/C pwsh -File $installScript"
        
    Unregister-ScheduledTask "WSL" -TaskPath "\Post-Install\" -Confirm:$false -ErrorAction Ignore | Out-Null
    Register-ScheduledTask "WSL" -TaskPath "\Post-Install\" -Action $taskAction -Trigger $taskTrigger -RunLevel Highest | Out-Null
} else {
    $configScript = Join-Path -Path $PSScriptRoot -ChildPath ".\Install.WSL.Config.ps1"
    & $configScript
}
