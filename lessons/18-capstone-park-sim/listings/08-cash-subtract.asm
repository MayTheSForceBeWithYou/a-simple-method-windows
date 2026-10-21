; Listing 08: Unconditional cash subtraction (LESSON.md block 8)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     cash, 10
    sub     cash, 3
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END
