; Exercise: 11-parse-binop
;
; Exercise 11: parse binop
; AST for 2+3 folds to 5; exit 5.
;
; Contract: implement `ex_11_parse_binop` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; 11-parse-binop.asm: Parse binary operator (+/*), return operator kind
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_parse_binop:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_parse_binop in this file.
    call    ex_11_parse_binop
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
