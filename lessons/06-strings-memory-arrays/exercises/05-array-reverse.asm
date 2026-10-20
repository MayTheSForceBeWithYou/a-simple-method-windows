; Exercise 05: 05-array-reverse (Win32 port)
; Reverse dq 1,2,3,4 in place; exit first element 4.
; Build: ml64 /c /Fo05-array-reverse.obj 05-array-reverse.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-array-reverse.exe 05-array-reverse.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC

; TODO: Port from NASM to MASM (MS x64 ABI)
.ERR <TODO: Implement 05-array-reverse>

main PROC
    sub rsp, 32
    ; TODO: Implement
    .ERR <TODO: Complete implementation>
main ENDP
END
