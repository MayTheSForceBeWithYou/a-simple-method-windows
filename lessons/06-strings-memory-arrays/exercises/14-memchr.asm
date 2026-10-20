; Exercise 14: 14-memchr (Win32 port)
; Find 7 in bytes 3,5,7,9; index 2.
; Build: ml64 /c /Fo14-memchr.obj 14-memchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:14-memchr.exe 14-memchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 14-memchr>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
