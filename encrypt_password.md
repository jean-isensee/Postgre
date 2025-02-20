# Para criptografar a senha usando PowerShell
$SecurePassword = ConvertTo-SecureString "your_password" -AsPlainText -Force
$SecurePassword | ConvertFrom-SecureString | Set-Content "C:\path\to\password.txt"

# Para recuperar a senha criptografada usando PowerShell
@echo off
for /f "delims=" %%i in ('powershell -Command "Get-Content 'C:\path\to\password.txt' | ConvertTo-SecureString | ConvertFrom-SecureString -AsPlainText"') do set PGPASSWORD=%%i
