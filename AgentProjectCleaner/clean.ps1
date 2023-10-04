param
(
    [string]$RobotPath
)

$ProjectCleanPath = $RobotPath + "\Project\*"
$ProcessPath = $RobotPath + "\*"
$AppDataPath = $env:LOCALAPPDATA
#$AppDataTempPath = $AppDataPath + "\Temp\Primo.Studio\*"

Wait-Event -Timeout 20
$ProcessId = (Get-Process | where {$_.path -like $ProcessPath}).id
Wait-Process -Id $ProcessId
Wait-Event -Timeout 2
Remove-Item $ProjectCleanPath -Recurse -Force -Confirm:$false
#Remove-Item $AppDataTempPath -Recurse -Force -Confirm:$false