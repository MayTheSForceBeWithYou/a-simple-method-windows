; Exercise: 08-from-scratch-const-fold
;
; FROM SCRATCH: fold (1+2)*3 exit 9.
;
; Contract: implement `ex_08_from_scratch_const_fold` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_08_from_scratch_const_fold:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_const_fold in this file.
    call    ex_08_from_scratch_const_fold
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
