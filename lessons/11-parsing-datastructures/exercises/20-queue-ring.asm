; 20-queue-ring
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_queue_ring:PROC
main PROC
    ; TODO: implement ex_20_queue_ring (student routine; defined in solutions/).
    call    ex_20_queue_ring
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
