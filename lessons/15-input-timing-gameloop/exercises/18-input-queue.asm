; Exercise: 18-input-queue
;
; Exercise 18: input queue
; Enqueue event 9; dequeue; exit 9.
; Expected stdout: (none)
;
; Contract: implement `ex_18_input_queue` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

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
