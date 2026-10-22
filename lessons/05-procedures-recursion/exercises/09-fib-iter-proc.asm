; Exercise: 09-fib-iter-proc
;
; Iterative fib(10)=55.
;
; Contract: implement `ex_09_fib_iter_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 55
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_fib_iter_proc:PROC

; TODO: write ex_09_fib_iter_proc in this file.

main PROC
    sub     rsp, 40
    call    ex_09_fib_iter_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
