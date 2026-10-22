; Exercise: 15-rd-expect
;
; Expect char "(" present; exit 1.
;
; Contract: implement `ex_15_rd_expect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_rd_expect:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_rd_expect in this file.
    call    ex_15_rd_expect
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
