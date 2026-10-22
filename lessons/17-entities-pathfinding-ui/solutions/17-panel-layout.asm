; Exercise: 17-panel-layout
;
; Stack y += h+pad; h=10 pad=2 twice from 0 -> 24; exit 24.
; Expected stdout: (none)
; Expected exit: 24
;
.code
ex_17_panel_layout PROC
    sub rsp, 40
    xor ecx, ecx
    add rcx, 12
    add rcx, 12
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_panel_layout ENDP
main PROC
    sub     rsp, 40
    call    ex_17_panel_layout
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
