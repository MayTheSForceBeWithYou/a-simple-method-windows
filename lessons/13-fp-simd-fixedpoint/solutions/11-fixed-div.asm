; Exercise 11: fixed div
;
; Q16: (6<<16)/(2<<16) via (a<<16)/b style: ((6<<16)<<16)/(2<<16) careful. Simpler int: 6/2=3 exit 3.
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_11_fixed_div PROC
    sub rsp, 40
    mov eax, 6
    shl eax, 16
    mov ebx, 2
    shl ebx, 16
    movsxd rax, eax
    shl rax, 16
    movsxd rbx, ebx
    cqo
    idiv rbx
    shr rax, 16
        mov     eax, ecx
    add     rsp, 40
    ret
ex_11_fixed_div ENDP
main PROC
    sub     rsp, 40
    call    ex_11_fixed_div
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
