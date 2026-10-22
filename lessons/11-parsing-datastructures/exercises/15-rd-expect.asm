; 15-rd-expect
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_rd_expect:PROC
main PROC
    ; TODO: implement ex_15_rd_expect (student routine; defined in solutions/).
    call    ex_15_rd_expect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
