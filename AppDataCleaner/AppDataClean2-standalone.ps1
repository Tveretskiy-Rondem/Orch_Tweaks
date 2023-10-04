while ((get-process -ea silentlycontinue Primo.Robot).count -gt 0)
{
Wait-Event -Timeout 10
}

$AppDataPath = $env:LOCALAPPDATA
$AppDataTempPath = $AppDataPath + "\Temp\Primo.Studio\*"
Remove-Item $AppDataTempPath -Recurse -Force -Confirm:$false
