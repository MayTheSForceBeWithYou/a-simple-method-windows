; 21-fast-inv-stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_fast_inv_stub:PROC
main PROC
    ; TODO: implement ex_21_fast_inv_stub (student routine; defined in solutions/).
    call    ex_21_fast_inv_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
