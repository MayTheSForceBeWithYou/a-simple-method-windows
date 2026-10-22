; Exercise: 08-from-scratch-q8
;
; Exercise 08: from scratch q8
; FROM SCRATCH: Q8.8 1.5*2 exit integer 3.
;
; Contract: implement `ex_08_from_scratch_q8` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; 08-from-scratch-q8.asm: Q8.8 format: 8 int, 8 frac bits
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_q8:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_q8 in this file.
    call    ex_08_from_scratch_q8
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
