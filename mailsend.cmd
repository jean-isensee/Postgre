REM 
REM Send Notification mail
REM
set mailsenderdir=directory where mailsend program are installed
set mailsender=mailsend.exe
set smtpsender=gcinformaticablu@gmail.com
set smtpsenderfullname=Account Name
set smtpserver=smtp.gmail.com
set smtpport=465
set smtpuser=gcinformaticablu@gmail.com
set smtppwd=kdudzexaeidbbfoy
set mailto=jean.isensee@gmail.com

"%mailsenderdir%\%mailsender%" -ssl -smtp %smtpserver% -port %smtpport% -auth -user %smtpuser% -pass %smtppwd% -t %mailto% -f %smtpsender% -name "%smtpsenderfullname%" +cc +bc -q -sub %1 -M %2

