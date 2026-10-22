; Exercise: 22-stretch-coaster-excitement
;
; STRETCH: excitement score 42; exit 42.
; Expected stdout: (none)
; Expected exit: 42
;
.code
ex_22_stretch_coaster_excitement PROC
    sub rsp, 40
    mov rcx, 42
    mov     eax, 42
    add     rsp, 40
    ret
ex_22_stretch_coaster_excitement ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_coaster_excitement
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
