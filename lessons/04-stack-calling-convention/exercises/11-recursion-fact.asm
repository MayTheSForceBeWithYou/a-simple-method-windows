; Exercise: 11-recursion-fact
;
; Recursive fact(4)=24. MS x64 ABI.
;
; Contract: implement `ex_11_recursion_fact` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 24
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_11_recursion_fact:PROC

; TODO: write ex_11_recursion_fact in this file.

main PROC
    sub     rsp, 40
    call    ex_11_recursion_fact
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
