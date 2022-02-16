cd C:\Apps\Logs\
[string]$LogPath="C:\Apps\Logs\"
[string]$Logs="C:\Apps\Logs\*.log"
[string]$LogDelLog="C:\Apps\Logs\DelLog.txt"
[string]$LogArchivePath="C:\Apps\Logs\Archives\"
[string]$LogArchiveDelLog="C:\Apps\Logs\Archives\ArchiveDelLog.txt"
[string]$Today=Get-Date -f yyyyMMdd


if(!(Test-Path -Path $LogArchivePath )){
    try { New-Item -Path $LogArchivePath -ItemType directory } catch { }
}


if (Test-Path $LogDelLog) {
    try { Remove-Item $LogDelLog } catch { }
}

if (Test-Path $LogArchiveDelLog) {
    try { Remove-Item $LogArchiveDelLog } catch { }
}

dir $Logs | group  { $_.Name -replace '-\d\d\d\d\d\d\d\d.log$', '' } | %{
    $final=$_.Name
    $filename= "Archives\$final-$(Get-Date -f yyyyMMdd).zip"
    Write-Host "=>"$filename

    $subset.Group | %{
    try { Compress-Archive -Path $_ -DestinationPath $filename -Update -CompressionLevel Optimal } catch { }
    }
}


Get-ChildItem $LogPath -Force -ea 0 -Filter *.log |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-1)} |
Select-Object -Skip 1 |
ForEach-Object {
    Write-Host "LOG"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $LogDelLog -Append } catch { }
}

Get-ChildItem $LogArchivePath -Recurse -Force -ea 0 -Filter *.zip |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(0)} |
ForEach-Object {
    Write-Host "ARC"$_.FullName
    try { $_ | del -Force } catch { }
    try { "$Today | $_" | Out-File $LogArchiveDelLog -Append } catch { }
}


