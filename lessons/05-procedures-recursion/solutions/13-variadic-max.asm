; Exercise 13: variadic max
; max_n(n, ...) MS x64: rcx=count, args on stack. max(3, 5,1,9)=9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
ex_13_variadic_max PROC
    sub rsp, 72
    mov rcx, 3
    mov QWORD PTR [rsp+32], 5
    mov QWORD PTR [rsp+40], 1
    mov QWORD PTR [rsp+48], 9
    call max_n
        mov     eax, rax
    ret

ex_13_variadic_max ENDP
main PROC
    call    ex_13_variadic_max
    mov     rcx, rax
    call    ExitProcess
main ENDP

max_n PROC
    mov rax, QWORD PTR [rsp+40]
    mov r8, 1
loop_max:
    cmp r8, rcx
    jge done_max
    mov rdx, QWORD PTR [rsp+40+r8*8]
    cmp rdx, rax
    cmovg rax, rdx
    inc r8
    jmp loop_max
done_max:
    ret
max_n ENDP
END
