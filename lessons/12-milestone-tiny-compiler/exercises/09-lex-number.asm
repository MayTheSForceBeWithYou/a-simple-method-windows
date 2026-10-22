; Exercise: 09-lex-number
;
; Exercise 09: lex number
; Parse "42" into int; exit 42.
;
; Contract: implement `ex_09_lex_number` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; 09-lex-number.asm: Scan multi-digit number "42", exit 42
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_lex_number:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_lex_number in this file.
    call    ex_09_lex_number
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
