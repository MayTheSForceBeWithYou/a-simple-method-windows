; Exercise: 17-flip-flags
;
; HFLIP|VFLIP = 3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.code
ex_17_flip_flags PROC
    sub rsp, 40
    mov rcx, HFLIP
    or rcx, VFLIP
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_flip_flags ENDP
main PROC
    sub     rsp, 40
    call    ex_17_flip_flags
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
