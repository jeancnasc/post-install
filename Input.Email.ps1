$email = [Environment]::GetEnvironmentVariable('POST_INSTALL_EMAIL', 'User')
if($null -eq $email){
    $email = Read-Host -Prompt "Informe seu E-Mail"
    [Environment]::SetEnvironmentVariable('POST_INSTALL_EMAIL', $email, 'User')
} else {
    Write-Host "E-Mail: $email"
}
$env:POST_INSTALL_EMAIL=$email