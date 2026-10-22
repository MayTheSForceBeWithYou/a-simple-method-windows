; Exercise: 05-sar-sign
;
; Implement `ex_05_sar_sign` in this file.
;
; Contract: implement `ex_05_sar_sign` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 252
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_sar_sign:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_sar_sign in this file.
    call    ex_05_sar_sign
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
