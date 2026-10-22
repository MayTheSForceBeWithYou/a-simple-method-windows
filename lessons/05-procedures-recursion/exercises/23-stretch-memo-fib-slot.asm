; Exercise: 23-stretch-memo-fib-slot
;
; Memoized fib(8)=21. Exit 21.
;
; Contract: implement `ex_23_stretch_memo_fib_slot` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 21
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_23_stretch_memo_fib_slot:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_23_stretch_memo_fib_slot in this file.
    call    ex_23_stretch_memo_fib_slot
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
