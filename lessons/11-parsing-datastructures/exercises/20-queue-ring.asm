; 20-queue-ring
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_queue_ring:PROC
main PROC
    ; TODO: write ex_20_queue_ring in this file.
    call    ex_20_queue_ring
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
