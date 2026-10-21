; Exercise 10: map erase
;
; Erase cell to EMPTY=0; exit 0.
;
; Expected exit: 0
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
map BYTE 256 DUP(0)

.code
main PROC
    sub rsp, 40
    mov BYTE PTR [map+5], 1
    mov BYTE PTR [map+5], 0
    movzx rcx, BYTE PTR [map+5]
    call ExitProcess
main ENDP
END
