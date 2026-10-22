; Exercise: 12-parse-paren
;
; Exercise 12: parse paren
; (1+2)*3 = 9; exit 9.
;
; Contract: implement `ex_12_parse_paren` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;

; 12-parse-paren.asm: Parse (1+2), return inner value 3
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_12_parse_paren:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_12_parse_paren in this file.
    call    ex_12_parse_paren
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
