; Exercise: 10-q16-frac
;
; Exercise 10: q16 frac
; 0.5 in Q16.16 is 1<<15; add two -> 1.0; exit 1.
;
; Contract: implement `ex_10_q16_frac` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 10-q16-frac.asm: Two halves (0.5+0.5=1.0), exit 1
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_q16_frac:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_q16_frac in this file.
    call    ex_10_q16_frac
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
