; Listing 09: Upkeep subtract with unsigned guard (LESSON.md block 9)
; Expected exit: 7
; Expected stdout: (none)

.DATA?
cash QWORD ?
upkeep QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     cash, 10
    mov     upkeep, 3
    mov     rax, cash
    cmp     rax, upkeep
    jb      skip
    sub     rax, upkeep
    mov     cash, rax
skip:
    mov     ecx, DWORD PTR cash
    call    ExitProcess
main ENDP
END
