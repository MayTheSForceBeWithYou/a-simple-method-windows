; Exercise: 20-queue-ring
;
; Exercise 20: queue ring
; Ring buffer cap 4; enqueue 7,8; dequeue; exit 7.
;
; Contract: implement `ex_20_queue_ring` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; 20-queue-ring
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_queue_ring:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_queue_ring in this file.
    call    ex_20_queue_ring
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
