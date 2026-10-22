; 21-fast-inv-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_fast_inv_stub:PROC
main PROC
    ; TODO: write ex_21_fast_inv_stub in this file.
    call    ex_21_fast_inv_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
