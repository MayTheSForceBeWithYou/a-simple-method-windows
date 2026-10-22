; Exercise: 08-from-scratch-stride
;
; FROM SCRATCH: stride=width*bpp; w=16 bpp=4; exit 64.
; Expected stdout: (none)
; Expected exit: 64
;
.code
ex_08_from_scratch_stride PROC
    sub rsp, 40
    mov rcx, 16
    imul rcx, 4
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_stride ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_stride
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
