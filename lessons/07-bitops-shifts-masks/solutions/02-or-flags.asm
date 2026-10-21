; Exercise 02: or flags
; Set bits 0 and 2; exit 5.
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
    or rcx, 1
    or rcx, 4
    call ExitProcess
main ENDP
END
