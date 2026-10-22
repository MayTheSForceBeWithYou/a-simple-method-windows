; Exercise: 24-from-scratch-vector-push
;
; FROM SCRATCH: dynamic array len/cap; push 3 values; exit len 3.
;
; Contract: implement `ex_24_from_scratch_vector_push` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_vector_push:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_vector_push in this file.
    call    ex_24_from_scratch_vector_push
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
