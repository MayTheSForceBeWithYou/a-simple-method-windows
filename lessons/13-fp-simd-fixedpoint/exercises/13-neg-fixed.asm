; Exercise: 13-neg-fixed
;
; Exercise 13: neg fixed
; Negate Q16.16 value -2.0; exit 2 (integer part of +2.0).
;
; Contract: implement `ex_13_neg_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 13-neg-fixed.asm: Negate Q16.16 value, exit result
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_neg_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_neg_fixed in this file.
    call    ex_13_neg_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
