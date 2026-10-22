; Exercise: 17-label-arith
;
; msg BYTE 'A','B','C',CR,LF. Write only 'B' using msg+1 length 1, then write CR,LF from msg+3. Exit 0.
;
; Contract: implement `ex_17_label_arith` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_17_label_arith:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_17_label_arith in this file.
    call    ex_17_label_arith
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
