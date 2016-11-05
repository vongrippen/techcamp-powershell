
$repos = Invoke-RestMethod -Uri 'https://api.github.com/users/vongrippen/repos?per_page=9999999'

$repos | Format-Table

$repos | Select full_name,fork | Out-GridView
