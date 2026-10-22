; 15-econ-ticket: econ ticket
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_econ_ticket:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_econ_ticket in this file.
    call    ex_15_econ_ticket
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
