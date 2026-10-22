; Exercise: 02-lex-ident
;
; Accept first char alpha; 'a' -> 1.
;
; Contract: implement `ex_02_lex_ident` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_lex_ident:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_lex_ident in this file.
    call    ex_02_lex_ident
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
