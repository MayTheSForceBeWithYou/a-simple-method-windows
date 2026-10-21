; Exercise 10: bit set clear
; Set bit 3, then clear it; exit 0.
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor rcx, rcx
    or rcx, (1 SHL 3)
    and rcx, NOT (1 SHL 3)
    call ExitProcess
main ENDP
END
