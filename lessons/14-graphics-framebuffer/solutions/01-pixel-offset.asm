; Exercise: 01-pixel-offset
;
; offset=y*stride+x*4; y=2,x=3,stride=40; exit offset&255.
; Expected stdout: (none)
; Expected exit: 92
;
.code
ex_01_pixel_offset PROC
    sub rsp, 40
    mov rax, 2
    imul rax, 40
    mov rbx, 3
    imul rbx, 4
    add rax, rbx
    and rax, 255
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_01_pixel_offset ENDP
main PROC
    sub     rsp, 40
    call    ex_01_pixel_offset
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
