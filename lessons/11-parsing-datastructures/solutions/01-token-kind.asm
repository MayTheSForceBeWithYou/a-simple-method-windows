; Exercise 01: token kind
;
; Token kinds as equ; exit TK_NUM=1.
; Expected exit: 1

EXTERN ExitProcess:PROC

TK_EOF EQU 0
TK_NUM EQU 1

.code
main PROC
    sub rsp, 40
    mov rcx, TK_NUM
    call ExitProcess
main ENDP
END
