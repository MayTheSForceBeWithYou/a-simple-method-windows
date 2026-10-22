; Exercise: 09-key-down-up
;
; Track key state: down sets, up clears; exit 0.
; Expected stdout: (none)
; Expected exit: 0
;
.data?
key_w BYTE ?

.code
ex_09_key_down_up PROC
    sub rsp, 40
    mov BYTE PTR [key_w], 1
    mov BYTE PTR [key_w], 0
    movzx rcx, BYTE PTR [key_w]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_09_key_down_up ENDP
main PROC
    sub     rsp, 40
    call    ex_09_key_down_up
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
