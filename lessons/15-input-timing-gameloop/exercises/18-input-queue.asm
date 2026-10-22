; 18-input-queue: input queue
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_input_queue:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_18_input_queue in this file.
    call    ex_18_input_queue
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
