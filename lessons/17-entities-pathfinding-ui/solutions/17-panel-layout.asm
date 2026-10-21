; Exercise 17: panel layout
;
; Stack y += h+pad; h=10 pad=2 twice from 0 -> 24; exit 24.
;
; Expected exit: 24
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    xor ecx, ecx
    add rcx, 12
    add rcx, 12
    call ExitProcess
main ENDP
END
