SetTimer, bailOut, 6000 ; exits after one minute
return

bailOut:
ExitApp

; Wait until windows becomes visible
while !WinExist("Paste Into File")
	Sleep, 200

; Approve the message box confirmation
ControlSend, , {Space}, Paste Into File
