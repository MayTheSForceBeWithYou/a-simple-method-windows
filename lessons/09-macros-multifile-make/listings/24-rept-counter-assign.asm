; Listing 24: = reassignment inside REPT (LESSON.md)
; Expected exit: 4
; Expected stdout: (none)

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     rcx, rcx
    i = 0
    REPT 4
        inc     rcx
        i = i + 1
    ENDM
    call    ExitProcess
main ENDP
END
