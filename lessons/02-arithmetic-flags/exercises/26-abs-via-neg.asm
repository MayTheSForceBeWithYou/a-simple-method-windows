; Exercise: 26-abs-via-neg
;
; rax=-42. Absolute value via neg. Exit 42.
;
; Contract: implement `ex_26_abs_via_neg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_26_abs_via_neg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_abs_via_neg in this file.
    call    ex_26_abs_via_neg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
