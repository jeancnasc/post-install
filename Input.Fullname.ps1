$fullname = [Environment]::GetEnvironmentVariable('POST_INSTALL_FULLNAME', 'User')
if($null -eq $fullname){
    $fullname = Read-Host -Prompt "Informe seu Nome Completo"
    [Environment]::SetEnvironmentVariable('POST_INSTALL_FULLNAME', $fullname, 'User')
} else {
    Write-Host "Nome Completo: $fullname"
}
$env:POST_INSTALL_FULLNAME=$fullname