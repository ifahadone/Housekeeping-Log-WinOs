# Housekeeping-Log-WinOs

## About

- Powershell (version `≥ 5`)
- Dependencies : None

## Task/Feature

- Ensure running script as `Administrator`
- Create Task Scheduler to run `daily` at `1am`
- Remove if exist legacy scheduler `Apache Logs Housekeeping` & `Apps Logs Housekeeping` created by vendor.
- Create `C:\Apps\Logs\` and `C:\Apps\Logs\Archives` folder if not exist
- Group Application Logs using `Application Name` as prefix
- Delete `1` day older `.log` files (skip the current/todays on-going logs)
- Delete `60` days older `.zip` files

## Run/Test

- Make sure your `C:\Apps\Logs\` already has logs in it.
- if no sample logs, run `tester.ps1` to simulate logs as follows,
    - it will create dummy logs file and
    - it will also override `created date` backward so that can test `1`, `60` days old files
- Run the `LogManager.ps1` as `Administrator`