@echo off
REM Set the PostgreSQL environment variables
set PGPASSWORD=your_password
set PGUSER=your_username
set PGHOST=localhost
set PGPORT=5432
set PGDATABASE=postgres

REM Define backup directory
set BACKUP_DIR=C:\path\to\backup\directory

REM Define backup filename (with date and time)
set BACKUP_FILE=%BACKUP_DIR%\pg_dumpall_%DATE%_%TIME%.sql

REM Run pg_dumpall to back up the database
echo Backing up PostgreSQL database...
pg_dumpall -h %PGHOST% -p %PGPORT% -U %PGUSER% -f %BACKUP_FILE%

REM Check if backup was successful
if %errorlevel% neq 0 (
    echo Backup failed. Exiting...
    exit /b %errorlevel%
)

echo Backup completed successfully.

REM Delete files older than 48 hours
echo Cleaning up old backups...
forfiles /p "%BACKUP_DIR%" /s /m *.sql /d -2 /c "cmd /c del @path"

REM Done
echo Cleanup completed.
exit /b 0
