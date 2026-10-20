; Exercise 08: 08-from-scratch-strchr (Win32 port)
; FROM SCRATCH: strchr for 'c' in 'abcd'; return index 2.
; Build: ml64 /c /Fo08-from-scratch-strchr.obj 08-from-scratch-strchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-from-scratch-strchr.exe 08-from-scratch-strchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 08-from-scratch-strchr>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
