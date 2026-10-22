; Exercise: 24-from-scratch-macro-abs
;
; FROM SCRATCH: MACRO ABS for register; ABS rcx with -9 -> 9 exit 9.
; Expected exit: 9
;
.code
ex_24_from_scratch_macro_abs PROC
    sub rsp, 40
    
    mov rcx, -9
    ABS rcx
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_from_scratch_macro_abs ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_macro_abs
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
