; Exercise 03: 03-memcmp (Win32 port)
; memcmp 3 bytes; equal -> 0 exit.
; Build: ml64 /c /Fo03-memcmp.obj 03-memcmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-memcmp.exe 03-memcmp.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 03-memcmp>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
