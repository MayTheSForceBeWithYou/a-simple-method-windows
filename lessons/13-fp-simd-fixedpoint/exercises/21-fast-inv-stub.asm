; Exercise: 21-fast-inv-stub
;
; Integer reciprocal stub for 1/2 of 10 -> 5; exit 5.
;
; Contract: implement `ex_21_fast_inv_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_fast_inv_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_fast_inv_stub in this file.
    call    ex_21_fast_inv_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
