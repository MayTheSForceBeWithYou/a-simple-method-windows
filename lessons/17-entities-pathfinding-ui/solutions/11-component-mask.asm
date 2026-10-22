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

ex_11_component_mask PROC
mov rcx, POS
    or rcx, VEL
    mov     eax, ecx
    ret
ex_11_component_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_11_component_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
