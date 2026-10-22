; Exercise: 24-from-scratch-q8-mul
;
; FROM SCRATCH: Q8.8 2.5 * 2 = 5; exit 5.
;
; Contract: implement `ex_24_from_scratch_q8_mul` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_q8_mul:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_q8_mul in this file.
    call    ex_24_from_scratch_q8_mul
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
