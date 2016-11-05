$cred = Get-Credential
$session = New-PSSession -ComputerName 172.21.21.99 -Credential $cred
Enter-PSSession $session