; Exercise: 21-gray-code
;
; Expected exit: 4
;
.code
ex_21_gray_code PROC
    sub rsp, 40
    mov rax, 7
    mov rbx, rax
    shr rbx, 1
    xor rax, rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_21_gray_code ENDP
main PROC
    sub     rsp, 40
    call    ex_21_gray_code
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
