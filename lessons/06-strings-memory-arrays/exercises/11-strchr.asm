; Exercise 11: 11-strchr (Win32 port)
; Find index of "l" in "hello" -> 2.
; Build: ml64 /c /Fo11-strchr.obj 11-strchr.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-strchr.exe 11-strchr.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 11-strchr>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
