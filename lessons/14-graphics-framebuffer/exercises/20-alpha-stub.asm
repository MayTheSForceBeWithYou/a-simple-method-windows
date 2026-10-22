; 20-alpha-stub: alpha stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_alpha_stub:PROC
main PROC
    ; TODO: implement ex_20_alpha_stub (student routine; defined in solutions/).
    call    ex_20_alpha_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
