; 14-ride-queue-len: ride queue len
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_ride_queue_len:PROC
main PROC
    ; TODO: implement ex_14_ride_queue_len (student routine; defined in solutions/).
    call    ex_14_ride_queue_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
