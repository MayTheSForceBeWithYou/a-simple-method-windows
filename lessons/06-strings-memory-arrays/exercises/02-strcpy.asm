; Exercise 02: 02-strcpy (Win32 port)
; Copy 'yo' to bss; return length written 2; exit 2.
; Build: ml64 /c /Fo02-strcpy.obj 02-strcpy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-strcpy.exe 02-strcpy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 02-strcpy>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
