cd C:\Apps\Logs\

# LOG & ARCHIVE DIRECTORIES
[string]$LogPath="C:\Apps\Logs\"
[string]$LogArchivePath="C:\Apps\Logs\Archives\"

# PS LOGS FILES
[string]$DelLog="C:\Apps\Logs\DelLog.txt"
[string]$ArchiveDelLog="C:\Apps\Logs\Archives\ArchiveDelLog.txt"

# CHECK IF USER ADMINSTRATOR
$elevated = ([Security.Principal.WindowsPrincipal] `
 [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
Write-Host "Me= $elevated"

# CREATE SCHEDULER
$TRIGGER = New-ScheduledTaskTrigger -At 01:00am -Daily
$USER = "System"
$ACTION = New-ScheduledTaskAction powershell.exe -Argument “-file C:\Users\fahad\Repos\LogCompresser.ps1" 
$TASK_NAME="LogMaster"
$TASK_DESC="Manage K2 Logs and Archives"
Register-ScheduledTask -TaskName $TASK_NAME -Description $TASK_DESC -Trigger $TRIGGER -User $USER -Action $ACTION





# DELETE IF REDUNDANT SCHEDULER EXIST #1
[string]$apachelogs="Apache Logs Housekeeping"
Get-ScheduledTask -TaskName $apachelogs -ErrorAction SilentlyContinue -OutVariable apachelogstask
if ($apachelogstask) {
    Get-ScheduledTask -TaskName $apachelogs | Unregister-ScheduledTask -Confirm:$false
    }

# DELETE IF REDUNDANT SCHEDULER EXIST #2
[string]$appslogs="Apps Logs Housekeeping"
Get-ScheduledTask -TaskName $appslogs -ErrorAction SilentlyContinue -OutVariable appslogstask
if ($appslogstask) {
    Get-ScheduledTask -TaskName $appslogstask | Unregister-ScheduledTask -Confirm:$false
    }

# CREATE IF LOG PATH NOT EXIST
if(!(Test-Path -Path $LogPath )){
    try { New-Item -Path $LogPath -ItemType directory } catch { }
}

# CREATE IF ARCHIVE PATH NOT EXIST
if(!(Test-Path -Path $LogArchivePath )){
    try { New-Item -Path $LogArchivePath -ItemType directory } catch { }
}

# REMOVE PS DEL-LOG
if (Test-Path $DelLog) {
    try { Remove-Item $DelLog } catch { }
}

# REMOVE PS DEL-ARCHIVE-LOG
if (Test-Path $ArchiveDelLog) {
    try { Remove-Item $ArchiveDelLog } catch { }
}
# FIND LOGS WITH REGEX AND GROUP THEM FOLLOWED BY COMPRESSION
[string]$Logs="C:\Apps\Logs\*.log"
[string]$Today=Get-Date -f _yyyy-MM-dd
dir $Logs | group  { $_.Name -replace '-\d\d\d\d\d\d\d\d.log$', ''} | %{
    $subset = $_
    $finalName= $LogArchivePath+$subset.Name+$Today
    Write-Host $subset.Name

    $subset.Group | %{
        #$error.clear()
        Compress-Archive $_ $finalName -Update -CompressionLevel Optimal
    }
}

# DELETE LOGS OLDER THAN #1 DAY
[string]$Today=Get-Date -f yyyyMMdd
Get-ChildItem $LogPath -Force -ea 0 -Filter *.log |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-1)} |
Select-Object -Skip 1 |
ForEach-Object {
    Write-Host "LOG"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $DelLog -Append } catch { }
}

# DELETE ARCHIVE OLDER THAN #60 DAY
Get-ChildItem $LogArchivePath -Recurse -Force -ea 0 -Filter *.zip |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-60)} |
ForEach-Object {
    Write-Host "ARC"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $ArchiveDelLog -Append } catch { }
}


