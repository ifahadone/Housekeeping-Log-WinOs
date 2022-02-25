#Requires -RunAsAdministrator
param ( ` [string]$skip = $false ` )
[string]$LOG_PATH = "C:\Apps\Logs\";
[string]$LOG_ARC_PATH = "C:\Apps\Logs\Archives\";
[string]$LOGGER_DEL = "C:\Apps\Logs\DelLog.txt";
[string]$LOGGER_ARC_DEL = "C:\Apps\Logs\Archives\ArchiveDelLog.txt";
[string]$TODAY = Get-Date -f yyyyMMdd;
[string]$IS_DEB = $false; [string]$LOGGER_DEBUG = "C:\Apps\Logs\Debug.txt";

function debug {
    [CmdletBinding()] ` param( `	[Parameter()] `	[string] $a ) `
        if ($IS_DEB -eq $true) { try { "$TODAY | $a" | Out-File $LOGGER_DEBUG -Append } catch { } }
}

$elevated = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
debug -a "elevation $elevated"
if ($elevated -eq $true -And $skip -eq $false) {
    $Trigger = New-ScheduledTaskTrigger -At 01:00am -Daily;$Action = New-ScheduledTaskAction powershell.exe -Argument "-file $PSCommandPath -skip $true"
    [string]$User = "System"; [string]$Task_Name = "LogMaster"; [string]$Task_Desc = "Manage K2 Logs and Archives"
    debug -a "Registering $Task_Name"
    Register-ScheduledTask -TaskName $Task_Name -Description $Task_Desc -Trigger $Trigger -User $User -Action $Action

    [string]$Sched_Apachelogs = "Apache Logs Housekeeping"
    Get-ScheduledTask -TaskName $Sched_Apachelogs -ErrorAction SilentlyContinue -OutVariable isSchedApachelogs
    if ($isSchedApachelogs -eq $true) {
        debug -a "Unregistering $Sched_Apachelogs"
        Get-ScheduledTask -TaskName $Sched_Apachelogs | Unregister-ScheduledTask -Confirm:$false
    }

    [string]$Sched_Appslogs = "Apps Logs Housekeeping"
    Get-ScheduledTask -TaskName $Sched_Appslogs -ErrorAction SilentlyContinue -OutVariable isSchedAppslogs
    if ($isSchedAppslogs -eq $true) {
        debug -a "Unregistering $Sched_Appslogs"
        Get-ScheduledTask -TaskName $Sched_Appslogs | Unregister-ScheduledTask -Confirm:$false
    }
}


if (!(Test-Path -Path $LOG_PATH )) { try { New-Item -Path $LOG_PATH -ItemType directory } catch { }}
if (!(Test-Path -Path $LOG_ARC_PATH )) { try { New-Item -Path $LOG_ARC_PATH -ItemType directory } catch { }}
if (Test-Path $LOGGER_DEL) { try { Remove-Item $LOGGER_DEL } catch { }}
if (Test-Path $LOGGER_ARC_DEL) { try { Remove-Item $LOGGER_ARC_DEL } catch { }}

[string]$Logs = "C:\Apps\Logs\*.log";
[string]$TODAYD = Get-Date -f _yyyy-MM-dd;
dir $Logs | group { $_.Name -replace '-\d\d\d\d\d\d\d\d.log$', '' } | % {
    $subset = $_; $finalName = $LOG_ARC_PATH + $subset.Name + $TODAYD;
    $subset.Group | % { Compress-Archive $_ $finalName -Update -CompressionLevel Optimal }
}


Get-ChildItem $LOG_PATH -Force -ea 0 -Filter *.log |
? { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-1) } |
ForEach-Object {
    debug -a "Del Log: $_.FullName"
    try { $_ | del -Force } catch { }
    try { "$TODAY | $_" | Out-File $LOGGER_DEL -Append } catch { }
}

Get-ChildItem $LOG_ARC_PATH -Recurse -Force -ea 0 -Filter *.zip |
? { !$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-60) } |
ForEach-Object {
    debug -a "Del Arc: $_.FullName"
    try { $_ | del -Force } catch { }
    try { "$TODAY | $_" | Out-File $LOGGER_ARC_DEL -Append } catch { }
}