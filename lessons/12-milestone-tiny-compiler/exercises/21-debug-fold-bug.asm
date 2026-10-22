; 21-debug-fold-bug.asm: Debug: wrong precedence 1+2*3 → fix to get 7 not 9
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_fold_bug:PROC
main PROC
    ; TODO: write ex_21_debug_fold_bug in this file.
    call    ex_21_debug_fold_bug
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
