@echo off

:: Set PostgreSQL credentials and backup path
set PG_HOST=localhost
set PG_PORT=5432
set PG_USER=your_username
for /f "delims=" %%i in ('powershell -Command "Get-Content 'C:\path\to\password.txt' | ConvertTo-SecureString | ConvertFrom-SecureString -AsPlainText"') do set PGPASSWORD=%%i
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
    %BACKUP_DIR$\scripts\mailsend.cmd "Diff Backup Falhou" "Diff Backup Falhou. Errorlevel %errorlevel%"
    exit /b %errorlevel%
) else (
    %BACKUP_DIR$\scripts\mailsend.cmd "Diff Backup Completado" "Diff Backup Completado com sucesso"
)

exit /b 0
