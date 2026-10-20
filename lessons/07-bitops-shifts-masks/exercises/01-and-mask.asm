; Exercise (Win32 port)
; TODO: Port from NASM
; Build: ml64 /c /FoEXERCISE.obj EXERCISE.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:EXERCISE.exe EXERCISE.obj kernel32.lib
.CODE
EXTRN ExitProcess:PROC
.ERR <TODO: Implement>
main PROC
sub rsp,32
.ERR <TODO>
main ENDP
END
