; 08-from-scratch-const-fold.asm: Fold (1+2)*3 with correct precedence, exit 9
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_const_fold:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_const_fold in this file.
    call    ex_08_from_scratch_const_fold
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
