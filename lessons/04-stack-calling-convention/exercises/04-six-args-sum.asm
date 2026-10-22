; Exercise: 04-six-args-sum
;
; Exercise 04: six args sum
; sum6(a..f): first 4 in regs, 5th and 6th on stack. Pass 1..6; exit 21.
;
; Contract: implement `ex_04_six_args_sum` (MS x64). Return exit code in EAX.
; Expected exit: 21
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_six_args_sum:PROC

; TODO: write ex_04_six_args_sum in this file.

main PROC
    sub     rsp, 40
    call    ex_04_six_args_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
