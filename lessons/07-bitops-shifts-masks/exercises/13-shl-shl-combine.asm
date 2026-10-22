; Exercise: 13-shl-shl-combine
;
; Implement `ex_13_shl_shl_combine` in this file.
;
; Contract: implement `ex_13_shl_shl_combine` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 171
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_13_shl_shl_combine:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_shl_shl_combine in this file.
    call    ex_13_shl_shl_combine
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
