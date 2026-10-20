; Exercise 17: 17-bounded-strcpy (Win32 port)
; Copy at most 3 chars + NUL from "abcdef" into 4-byte dst; strlen dst=3.
; Build: ml64 /c /Fo17-bounded-strcpy.obj 17-bounded-strcpy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-bounded-strcpy.exe 17-bounded-strcpy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 17-bounded-strcpy>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
