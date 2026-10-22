; 09-lexer-skip-ws
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_lexer_skip_ws:PROC
main PROC
    ; TODO: implement ex_09_lexer_skip_ws (student routine; defined in solutions/).
    call    ex_09_lexer_skip_ws
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
