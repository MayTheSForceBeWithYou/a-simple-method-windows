; Exercise: 12-recursion-fib
;
; Exercise 12: recursion fib
; Naive fib(7)=13. MS x64 ABI.
;
; Contract: implement `ex_12_recursion_fib` (MS x64). Return exit code in EAX.
; Expected exit: 13
;

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_recursion_fib:PROC

; TODO: write ex_12_recursion_fib in this file.

main PROC
    sub     rsp, 40
    call    ex_12_recursion_fib
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
