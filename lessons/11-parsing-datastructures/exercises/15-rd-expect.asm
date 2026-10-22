; 15-rd-expect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_rd_expect:PROC
main PROC
    ; TODO: write ex_15_rd_expect in this file.
    call    ex_15_rd_expect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
