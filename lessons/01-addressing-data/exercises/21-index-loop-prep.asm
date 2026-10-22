; Exercise: 21-index-loop-prep
;
; arr BYTE 7,8,9. Without loops yet: sum using three scaled/byte loads into rcx (24).
;
; Contract: implement `ex_21_index_loop_prep` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 24
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_index_loop_prep:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_index_loop_prep in this file.
    call    ex_21_index_loop_prep
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
