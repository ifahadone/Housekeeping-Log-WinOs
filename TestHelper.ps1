# Unzip Arc
Expand-Archive -LiteralPath 'C:\W.Zip' -DestinationPath C:\Apps\Logs -Force

# EDIT LASTWRITE/ DATE MODIFIED DATE
(Get-Item "C:\Apps\Logs\Archives\WorkFlowManager-20220217.zip").LastWriteTime = '01/11/2019 06:00:36'

# Create Dummy Logs
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221110.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221210.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221310.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221410.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221510.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221610.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221710.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221812.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221912.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221012.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221112.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221212.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221312.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221412.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221512.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221612.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20221712.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221812.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221912.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20222011.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222111.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222211.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20222311.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222411.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222511.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20222611.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222711.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222811.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher2-20222911.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20223011.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221111.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222311.log" -ItemType File
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221211.log" -ItemType File


# Create Dummy Logs With LastWriteTime (EXPERIMENT)
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221110.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221110.log").LastWriteTime = '01/31/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221210.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221210.log").LastWriteTime = '02/15/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221310.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221310.log").LastWriteTime = '03/02/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221410.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221410.log").LastWriteTime = '03/17/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221510.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221510.log").LastWriteTime = '04/01/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221610.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221610.log").LastWriteTime = '04/16/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221710.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221710.log").LastWriteTime = '05/01/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221812.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221812.log").LastWriteTime = '05/16/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221912.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221912.log").LastWriteTime = '05/31/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221012.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221012.log").LastWriteTime = '06/15/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221112.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221112.log").LastWriteTime = '06/30/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221212.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221212.log").LastWriteTime = '07/15/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221312.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221312.log").LastWriteTime = '07/30/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221412.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221412.log").LastWriteTime = '08/14/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221512.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221512.log").LastWriteTime = '08/29/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221612.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221612.log").LastWriteTime = '09/13/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20221712.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20221712.log").LastWriteTime = '09/28/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221812.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221812.log").LastWriteTime = '10/13/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221912.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221912.log").LastWriteTime = '10/28/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20222011.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20222011.log").LastWriteTime = '11/12/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222111.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20222111.log").LastWriteTime = '11/27/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222211.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20222211.log").LastWriteTime = '12/12/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20222311.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20222311.log").LastWriteTime = '12/27/2021 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222411.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20222411.log").LastWriteTime = '01/11/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222511.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20222511.log").LastWriteTime = '01/26/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20222611.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20222611.log").LastWriteTime = '02/10/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222711.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20222711.log").LastWriteTime = '02/25/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20222811.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20222811.log").LastWriteTime = '03/12/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "MhBosDispather-Test-20222911.log" -ItemType File
(Get-Item "C:\Apps\Logs\MhBosDispather-Test-20222911.log").LastWriteTime = '03/27/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20223011.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20223011.log").LastWriteTime = '04/11/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowManager-20221111.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowManager-20221111.log").LastWriteTime = '04/26/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20222311.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20222311.log").LastWriteTime = '04/26/2022 06:00:36'
New-Item -Path 'C:\Apps\Logs\' -Name "WorkFlowDispatcher3-20221211.log" -ItemType File
(Get-Item "C:\Apps\Logs\WorkFlowDispatcher3-20221211.log").LastWriteTime = '04/26/2022 06:00:36'
