# Para criptografar a senha usando PowerShell
$SecurePassword = ConvertTo-SecureString "your_password" -AsPlainText -Force

$SecurePassword | ConvertFrom-SecureString | Set-Content "C:\path\to\password.txt"
