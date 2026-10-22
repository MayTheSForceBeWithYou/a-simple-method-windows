; Exercise: 01-token-kind
;
; Token kinds as equ; exit TK_NUM=1.
;
; Contract: implement `ex_01_token_kind` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_token_kind:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_token_kind in this file.
    call    ex_01_token_kind
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
