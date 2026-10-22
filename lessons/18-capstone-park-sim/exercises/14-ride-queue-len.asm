; 14-ride-queue-len: ride queue len
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_ride_queue_len:PROC
main PROC
    ; TODO: write ex_14_ride_queue_len in this file.
    call    ex_14_ride_queue_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
