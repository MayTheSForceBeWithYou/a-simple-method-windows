; 15-econ-ticket: econ ticket
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_econ_ticket:PROC
main PROC
    ; TODO: implement ex_15_econ_ticket (student routine; defined in solutions/).
    call    ex_15_econ_ticket
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
