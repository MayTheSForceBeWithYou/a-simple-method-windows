; Exercise: 02-lexer-digit
;
; If byte '7' is digit exit 1.
;
; Contract: implement `ex_02_lexer_digit` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_02_lexer_digit:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_lexer_digit in this file.
    call    ex_02_lexer_digit
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
