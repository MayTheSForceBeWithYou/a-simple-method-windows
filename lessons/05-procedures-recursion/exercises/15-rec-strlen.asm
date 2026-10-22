; Exercise: 15-rec-strlen
;
; Recursive strlen("abcd")=4.
;
; Contract: implement `ex_15_rec_strlen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_rec_strlen:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_15_rec_strlen in this file.
    call    ex_15_rec_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
