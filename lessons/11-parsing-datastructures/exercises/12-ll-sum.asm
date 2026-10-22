; 12-ll-sum
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_ll_sum:PROC
main PROC
    ; TODO: implement ex_12_ll_sum (student routine; defined in solutions/).
    call    ex_12_ll_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
