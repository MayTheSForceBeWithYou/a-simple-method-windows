; 18-input-queue: input queue
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_18_input_queue:PROC
main PROC
    ; TODO: implement ex_18_input_queue (student routine; defined in solutions/).
    call    ex_18_input_queue
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
