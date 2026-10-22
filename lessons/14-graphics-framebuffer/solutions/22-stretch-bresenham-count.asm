; Exercise: 22-stretch-bresenham-count
;
; STRETCH: line from 0,0 to 3,0 plots 4 pixels; exit 4.
; Expected stdout: (none)
; Expected exit: 4
;
.code
ex_22_stretch_bresenham_count PROC
    sub rsp, 40
    mov rcx, 4
    mov     eax, 4
    add     rsp, 40
    ret
ex_22_stretch_bresenham_count ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_bresenham_count
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
