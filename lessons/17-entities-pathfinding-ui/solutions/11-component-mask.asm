; Exercise 11: component mask
;
; Has POS|VEL = 3; exit 3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

POS EQU 1
VEL EQU 2

.code
main PROC
    sub rsp, 40
    mov rcx, POS
    or rcx, VEL
    call ExitProcess
main ENDP
END
