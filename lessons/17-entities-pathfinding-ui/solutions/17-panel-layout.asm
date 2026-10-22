; Exercise 17: panel layout
;
; Stack y += h+pad; h=10 pad=2 twice from 0 -> 24; exit 24.
;
; Expected exit: 24
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_17_panel_layout PROC
    sub rsp, 40
    xor ecx, ecx
    add rcx, 12
    add rcx, 12
    mov     eax, 24
    ret
    add     rsp, 40
ex_17_panel_layout ENDP
main PROC
    call    ex_17_panel_layout
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
