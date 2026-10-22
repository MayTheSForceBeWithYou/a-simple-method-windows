; Exercise: 10-lex-ident-len
;
; Ident "foo" length 3; exit 3.
;
; Contract: implement `ex_10_lex_ident_len` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_10_lex_ident_len:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_lex_ident_len in this file.
    call    ex_10_lex_ident_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
