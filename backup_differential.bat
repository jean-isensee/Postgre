@echo off
setlocal enabledelayedexpansion

:: Set PostgreSQL credentials and backup path
set PG_HOST=localhost
set PG_PORT=5432
set PG_USER=your_username
set PG_PASSWORD=your_password
set PG_DATABASE=your_database
set BACKUP_DIR=C:\backups\postgresql

:: Create a timestamp for the backup file
for /f "tokens=2 delims==." %%I in ('wmic OS Get localdatetime /value') do set datetime=%%I
set datestamp=%datetime:~0,8%_%datetime:~8,6%

:: Ensure backup directory exists
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"

:: Run pg_dump and save the backup
set BACKUP_FILE=%BACKUP_DIR%\backup_%PG_DATABASE%_%datestamp%.sql
"C:\Program Files\PostgreSQL\15\bin\pg_dump.exe" -h %PG_HOST% -p %PG_PORT% -U %PG_USER% -F c -b -v -f "%BACKUP_FILE%" %PG_DATABASE%

:: Check if the backup was successful
if %errorlevel% neq 0 (
    echo Backup failed!
    exit /b %errorlevel%
) else (
    echo Backup completed: %BACKUP_FILE%
)

exit /b 0
