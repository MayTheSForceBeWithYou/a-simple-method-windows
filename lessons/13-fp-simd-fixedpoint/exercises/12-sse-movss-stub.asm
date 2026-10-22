; Exercise: 12-sse-movss-stub
;
; Prefer portable: store float bits of 1.0 as imm and mask; exit 1 as success flag.
;
; Contract: implement `ex_12_sse_movss_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_sse_movss_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_sse_movss_stub in this file.
    call    ex_12_sse_movss_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
