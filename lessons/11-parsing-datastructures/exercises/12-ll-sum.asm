; Exercise: 12-ll-sum
;
; List 3->4->5; sum=12.
;
; Contract: implement `ex_12_ll_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_12_ll_sum:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_ll_sum in this file.
    call    ex_12_ll_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
