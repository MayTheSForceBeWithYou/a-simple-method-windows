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
ex_10_map_erase PROC
    sub rsp, 40
    mov BYTE PTR [map+5], 1
    mov BYTE PTR [map+5], 0
    movzx rcx, BYTE PTR [map+5]
    mov     eax, 0
    add     rsp, 40
    ret
ex_10_map_erase ENDP
main PROC
    sub     rsp, 40
    call    ex_10_map_erase
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
