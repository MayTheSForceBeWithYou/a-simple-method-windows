; Exercise: 10-factorial-iter-proc
;
; fact(n) iterative as procedure. fact(5)=120; exit 120.
;
; Contract: implement `ex_10_factorial_iter_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 120
;
; Implement iterative `factorial(n)` in a PROC. In `ex_10_factorial_iter_proc`, compute fact(5) and exit 120.
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_10_factorial_iter_proc:PROC

; TODO: write ex_10_factorial_iter_proc in this file.

main PROC
    sub     rsp, 40
    call    ex_10_factorial_iter_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
