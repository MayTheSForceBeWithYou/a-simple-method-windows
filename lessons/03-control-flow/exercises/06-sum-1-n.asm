; Exercise: 06-sum-1-n
;
; Sum 1..n for n=10 into rcx (55).
;
; Contract: implement `ex_06_sum_1_n` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 55
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_sum_1_n:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_sum_1_n in this file.
    call    ex_06_sum_1_n
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
