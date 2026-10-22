; Exercise: 08-div-remainder
;
; Unsigned: 20 / 6. Exit with remainder (rdx) = 2.
; Expected exit: 2
;
.code
ex_08_div_remainder PROC
    sub rsp, 40
    mov rax, 20
    xor rdx, rdx
    mov rbx, 6
    div rbx
    mov rcx, rdx
    mov     eax, edx
    add     rsp, 40
    ret
ex_08_div_remainder ENDP
main PROC
    sub     rsp, 40
    call    ex_08_div_remainder
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
