; 12-ll-sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_ll_sum:PROC
main PROC
    ; TODO: write ex_12_ll_sum in this file.
    call    ex_12_ll_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
