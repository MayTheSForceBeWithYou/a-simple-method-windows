; 07-stack-ds
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_07_stack_ds:PROC
main PROC
    ; TODO: write ex_07_stack_ds in this file.
    call    ex_07_stack_ds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
