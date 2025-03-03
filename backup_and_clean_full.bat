@echo off
REM Set the PostgreSQL environment variables
for /f "delims=" %%i in ('powershell -Command "Get-Content 'C:\path\to\password.txt' | ConvertTo-SecureString | ConvertFrom-SecureString -AsPlainText"') do set PGPASSWORD=%%i
set PGUSER=your_username
set PGHOST=localhost
set PGPORT=5432
set PGDATABASE=postgres

REM Define backup directory
set BACKUP_DIR=C:\path\to\backup\directory

REM Create a timestamp for the backup file
for /f "tokens=2 delims==." %%I in ('wmic OS Get localdatetime /value') do set datetime=%%I
set datestamp=%datetime:~0,8%_%datetime:~8,6%

REM Define backup filename (with date and time)
set BACKUP_FILE=%BACKUP_DIR%\FULL_%datestamp%.sql

REM Run pg_dumpall to back up the database
pg_dumpall -h %PGHOST% -p %PGPORT% -U %PGUSER% -f %BACKUP_FILE%

REM Check if backup was successful
if %errorlevel% neq 0 (
    %BACKUP_DIR$\scripts\mailsend.cmd "Full Backup Falhou" "Full Backup Falhou. Errorlevel %errorlevel%"
    exit /b %errorlevel%
)

REM Delete files older than 48 hours
forfiles /p "%BACKUP_DIR%" /s /m *.sql /d -2 /c "cmd /c del @path"

REM Done
%BACKUP_DIR$\scripts\mailsend.cmd "Full Backup Completado" "Full Backup Completadp com Sucesso."
exit /b 0
