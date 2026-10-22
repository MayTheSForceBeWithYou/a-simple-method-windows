; Exercise: 10-token-buffer
;
; Lexeme copy "let" into tok; len=3 exit 3.
;
; Contract: implement `ex_10_token_buffer` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_10_token_buffer:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_token_buffer in this file.
    call    ex_10_token_buffer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
