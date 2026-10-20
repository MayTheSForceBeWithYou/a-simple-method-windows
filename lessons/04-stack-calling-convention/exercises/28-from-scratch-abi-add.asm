; Exercise 28: from scratch abi add (Win32 port)
; FROM SCRATCH: implement and call add3(a,b,c)=a+b+c with MS x64 ABI; exit 42 for 10,20,12.
; Build: ml64 /c /Fo28-from-scratch-abi-add.obj 28-from-scratch-abi-add.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:28-from-scratch-abi-add.exe 28-from-scratch-abi-add.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement add3(RCX, RDX, R8) -> RAX from scratch
.ERR <TODO: Implement add3 and main from scratch>

; TODO: Implement main PROC calling add3 and ExitProcess
.ERR <TODO: Implement main>

END
