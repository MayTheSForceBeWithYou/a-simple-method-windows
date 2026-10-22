; Exercise: 07-repeat-macro
;
; REPT 3 increment; exit 3.
; Expected exit: 3
;
.code
ex_07_repeat_macro PROC
    sub rsp, 40
    
    xor rcx, rcx
    ; MASM uses REPT instead of %rep
    REPT 3
        inc rcx
    ENDM
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_07_repeat_macro ENDP
main PROC
    sub     rsp, 40
    call    ex_07_repeat_macro
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
