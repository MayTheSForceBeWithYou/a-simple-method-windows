; Exercise: 09-lexer-skip-ws
;
; Skip spaces before digit in "  7"; exit value 7.
;
; Contract: implement `ex_09_lexer_skip_ws` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_09_lexer_skip_ws:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_lexer_skip_ws in this file.
    call    ex_09_lexer_skip_ws
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
