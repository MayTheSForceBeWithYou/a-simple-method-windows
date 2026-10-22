; Exercise: 03-parse-let
;
; Exercise 03: parse let
; Recognize keyword first letter 'l' of let; exit 1.
;
; Contract: implement `ex_03_parse_let` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 03-parse-let.asm: Check first byte is 'l' (simplified keyword test), exit 1 if match
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_03_parse_let:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_parse_let in this file.
    call    ex_03_parse_let
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
