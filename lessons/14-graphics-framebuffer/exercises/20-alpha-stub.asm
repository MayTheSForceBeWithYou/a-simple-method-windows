; 20-alpha-stub: alpha stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_alpha_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_alpha_stub in this file.
    call    ex_20_alpha_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
