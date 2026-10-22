; Exercise: 24-stretch-variadic-sum
;
; STRETCH: sum_n(n, a,b,c,d) — n in rcx, remaining MS x64 args. sum_n(4,3,4,5,6)=18.
; Expected stdout: (none)
; Expected exit: 18
;
.code
ex_24_stretch_variadic_sum PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 4
    mov rdx, 3
    mov r8, 4
    mov r9, 5
    mov QWORD PTR [rsp+32], 6
    call sum_n
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_24_stretch_variadic_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_24_stretch_variadic_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP

sum_n PROC
    xor rax, rax
    add rax, rdx
    add rax, r8
    add rax, r9
    add rax, QWORD PTR [rsp+40]
    ret
sum_n ENDP
END
