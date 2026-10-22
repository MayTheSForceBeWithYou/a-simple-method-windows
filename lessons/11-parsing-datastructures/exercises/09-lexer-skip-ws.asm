; 09-lexer-skip-ws
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_lexer_skip_ws:PROC
main PROC
    ; TODO: write ex_09_lexer_skip_ws in this file.
    call    ex_09_lexer_skip_ws
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
