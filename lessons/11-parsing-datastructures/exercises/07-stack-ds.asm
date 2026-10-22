; 07-stack-ds
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_stack_ds:PROC
main PROC
    ; TODO: implement ex_07_stack_ds (student routine; defined in solutions/).
    call    ex_07_stack_ds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
