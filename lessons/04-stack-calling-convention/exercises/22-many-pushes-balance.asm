; Exercise: 22-many-pushes-balance
;
; Push 1,2,3; call sum_top3 that reads [rsp+8],[rsp+16],[rsp+24] after call. Exit 6.
; Expected stdout: (none)
;
; Contract: implement `ex_22_many_pushes_balance` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 6
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_22_many_pushes_balance:PROC

; TODO: write ex_22_many_pushes_balance in this file.

main PROC
    sub     rsp, 40
    call    ex_22_many_pushes_balance
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
