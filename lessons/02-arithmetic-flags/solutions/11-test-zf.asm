; Exercise: 11-test-zf
;
; rax=0; test rax,rax; sete al; exit 1.
; Expected exit: 1
;
.code
ex_11_test_zf PROC
    sub rsp, 40
    xor rax, rax
    test rax, rax
    sete al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_test_zf ENDP
main PROC
    sub     rsp, 40
    call    ex_11_test_zf
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
