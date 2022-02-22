cd C:\Apps\Logs\

# LOG & ARCHIVE DIRECTORIES
[string]$LOG_PATH = "C:\Apps\Logs\"
[string]$LOG_ARC_PATH = "C:\Apps\Logs\Archives\"

# PS LOGS FILES
[string]$LOGGER_DEL = "C:\Apps\Logs\DelLog.txt"
[string]$LOGGER_ARC_DEL = "C:\Apps\Logs\Archives\ArchiveDelLog.txt"

# CHECK IF USER ADMINSTRATOR
$elevated = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Write-Host "Me= $elevated"

if ($elevated) {
    # CREATE SCHEDULER
    $Trigger = New-ScheduledTaskTrigger -At 01:00am -Daily
    $Action = New-ScheduledTaskAction powershell.exe -Argument “-file $PSCommandPath" 
    [string]$User = "System"
    [string]$Task_Name = "LogMaster"
    [string]$Task_Desc = "Manage K2 Logs and Archives"
    Get-ScheduledTask -TaskName $Task_Name -ErrorAction SilentlyContinue -OutVariable isLogMaster
    Write-Host "isLogMaster" $isLogMaster
    if (!$isLogMaster) {
        Register-ScheduledTask -TaskName $Task_Name -Description $Task_Desc -Trigger $Trigger -User $User -Action $Action
    }

    # DELETE IF REDUNDANT SCHEDULER EXIST #1
    [string]$Sched_Apachelogs = "Apache Logs Housekeeping"
    Get-ScheduledTask -TaskName $Sched_Apachelogs -ErrorAction SilentlyContinue -OutVariable isSchedApachelogs
    Write-Host "isSchedApachelogs" $isSchedApachelogs
    if ($isSchedApachelogs) {
        Get-ScheduledTask -TaskName $Sched_Apachelogs | Unregister-ScheduledTask -Confirm:$false
    }

    # DELETE IF REDUNDANT SCHEDULER EXIST #2
    [string]$Sched_Appslogs = "Apps Logs Housekeeping"
    Get-ScheduledTask -TaskName $Sched_Appslogs -ErrorAction SilentlyContinue -OutVariable isSchedAppslogs
    Write-Host "isSchedAppslogs" $isSchedAppslogs
    if ($isSchedAppslogs) {
        Get-ScheduledTask -TaskName $Sched_Appslogs | Unregister-ScheduledTask -Confirm:$false
    }
}

# CREATE IF LOG PATH NOT EXIST
if (!(Test-Path -Path $LOG_PATH )) {
    try { New-Item -Path $LOG_PATH -ItemType directory } catch { }
}

# CREATE IF ARCHIVE PATH NOT EXIST
if (!(Test-Path -Path $LOG_ARC_PATH )) {
    try { New-Item -Path $LOG_ARC_PATH -ItemType directory } catch { }
}

# REMOVE PS DEL-LOG
if (Test-Path $LOGGER_DEL) {
    try { Remove-Item $LOGGER_DEL } catch { }
}

# REMOVE PS DEL-ARCHIVE-LOG
if (Test-Path $LOGGER_ARC_DEL) {
    try { Remove-Item $LOGGER_ARC_DEL } catch { }
}
# FIND LOGS WITH REGEX AND GROUP THEM FOLLOWED BY COMPRESSION
[string]$Logs = "C:\Apps\Logs\*.log"
[string]$Today = Get-Date -f _yyyy-MM-dd
dir $Logs | group { $_.Name -replace '-\d\d\d\d\d\d\d\d.log$', '' } | % {
    $subset = $_
    $finalName = $LOG_ARC_PATH + $subset.Name + $Today
    Write-Host $subset.Name

    $subset.Group | % {
        #$error.clear()
        Compress-Archive $_ $finalName -Update -CompressionLevel Optimal
    }
}

# DELETE LOGS OLDER THAN #1 DAY
[string]$Today = Get-Date -f yyyyMMdd
Get-ChildItem $LOG_PATH -Force -ea 0 -Filter *.log |
? { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-1) } |
ForEach-Object {
    Write-Host "LOG"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $LOGGER_DEL -Append } catch { }
}

# DELETE ARCHIVE OLDER THAN #60 DAY
Get-ChildItem $LOG_ARC_PATH -Recurse -Force -ea 0 -Filter *.zip |
? { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-60) } |
ForEach-Object {
    Write-Host "ARC"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $LOGGER_ARC_DEL -Append } catch { }
}


