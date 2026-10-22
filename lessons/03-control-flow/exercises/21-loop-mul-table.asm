; Exercise: 21-loop-mul-table
;
; Compute 7*8 via repeated addition loop. Exit 56.
;
; Contract: implement `ex_21_loop_mul_table` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 56
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_loop_mul_table:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_loop_mul_table in this file.
    call    ex_21_loop_mul_table
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
