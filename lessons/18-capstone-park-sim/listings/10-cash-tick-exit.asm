; Listing 10: Economy tick exit cash (LESSON.md block 10)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     cash, 10
    sub     cash, 3
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END
