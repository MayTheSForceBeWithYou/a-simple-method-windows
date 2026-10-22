; Exercise: 22-stretch-flow-field
;
; STRETCH: flow cell cost 4; exit 4.
; Expected stdout: (none)
; Expected exit: 4
;
.code
ex_22_stretch_flow_field PROC
    sub rsp, 40
    mov rcx, 4
    mov     eax, 4
    add     rsp, 40
    ret
ex_22_stretch_flow_field ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_flow_field
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
