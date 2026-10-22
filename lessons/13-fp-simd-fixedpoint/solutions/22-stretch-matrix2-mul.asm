; Exercise 22: stretch matrix2 mul
;
; STRETCH: 2x2 identity * (3,4) -> 3; exit 3 (x).
; Expected exit: 3

EXTERN ExitProcess:PROC

.code

ex_22_stretch_matrix2_mul PROC
mov rcx, 3
    mov     eax, 3
    ret
ex_22_stretch_matrix2_mul ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_matrix2_mul
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
