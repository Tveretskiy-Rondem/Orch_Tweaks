param
(
    [string]$DataStr
)
$items = $DataStr.Split(",")
foreach ( $item in $items )
{
    $arr = $item.Split(";")
    $RobotPath = $arr[0]
    $RobotName = $arr[1]
    $RobotKey = $arr[2]
    $UserName = $arr[3]
    
    $robotExePath = $RobotPath + "\Primo.Robot.exe"

    $robotRunScriptPath = $RobotPath + "\run.ps1"
    $psArguments = "-NoProfile -File " + $robotRunScriptPath
    $taskName = "Run Robot " + $RobotName + "_" + $RobotKey

    $CIMCLass = Get-CimClass -ClassName 'MSFT_TaskRegistrationTrigger' -Namespace 'Root/Microsoft/Windows/TaskScheduler'
    $TaskTrigger = New-CimInstance -CimClass $CIMCLass -ClientOnly
    $TaskTrigger.Enabled = $true

    $action = New-ScheduledTaskAction -Execute "C:\Program Files\PowerShell\7\pwsh.exe" -Argument $psArguments
    $prin = New-ScheduledTaskPrincipal -UserId $UserName -LogonType Interactive -RunLevel Highest

    $runParams = @{
        Action = $action
        Trigger = @($TaskTrigger)
        TaskName = $taskName
        Description = "Run Robot"
        Principal = $prin
    }
    Register-ScheduledTask @runParams -Force

    $Path = $MyInvocation.MyCommand.Path | split-path -parent
    $CleanScriptPath = $Path + "\clean.ps1"

    Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass & $CleanScriptPath $RobotPath"
}

