; Exercise: 14-ride-queue-len
;
; Exercise 14: ride queue len
; Queue length 7; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_14_ride_queue_len` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 14-ride-queue-len: ride queue len
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_14_ride_queue_len:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_ride_queue_len in this file.
    call    ex_14_ride_queue_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
