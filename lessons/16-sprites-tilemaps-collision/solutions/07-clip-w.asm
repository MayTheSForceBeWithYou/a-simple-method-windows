; Exercise: 07-clip-w
;
; sprite w clipped; exit 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_07_clip_w PROC
    sub rsp, 40
    mov rcx, 2
    mov     eax, 2
    add     rsp, 40
    ret
ex_07_clip_w ENDP
main PROC
    sub     rsp, 40
    call    ex_07_clip_w
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
