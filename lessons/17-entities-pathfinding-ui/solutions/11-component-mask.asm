; Exercise: 11-component-mask
;
; Has POS|VEL = 3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.code
ex_11_component_mask PROC
    sub rsp, 40
    mov rcx, POS
    or rcx, VEL
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_component_mask ENDP
main PROC
    sub     rsp, 40
    call    ex_11_component_mask
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
