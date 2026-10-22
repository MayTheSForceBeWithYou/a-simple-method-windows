; Exercise: 17-vsync-stub
;
; Frame ready flag clear; exit 0.
; Expected stdout: (none)
; Expected exit: 0
;
.data?
ready BYTE ?

.code
ex_17_vsync_stub PROC
    sub rsp, 40
    mov BYTE PTR [ready], 0
    movzx rcx, BYTE PTR [ready]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_vsync_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_17_vsync_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
