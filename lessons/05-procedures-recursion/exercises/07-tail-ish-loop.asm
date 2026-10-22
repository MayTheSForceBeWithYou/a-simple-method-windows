; Exercise: 07-tail-ish-loop
;
; sum_to loop (tail form). sum_to(6)=21.
;
; Contract: implement `ex_07_tail_ish_loop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 21
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_tail_ish_loop:PROC

; TODO: write ex_07_tail_ish_loop in this file.

main PROC
    sub     rsp, 40
    call    ex_07_tail_ish_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
