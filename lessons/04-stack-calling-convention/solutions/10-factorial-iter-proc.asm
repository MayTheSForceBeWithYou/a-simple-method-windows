; Exercise: 10-factorial-iter-proc
;
; fact(n) iterative as procedure. fact(5)=120; exit 120.
; Expected exit: 120
;
.code
ex_10_factorial_iter_proc PROC
    sub rsp, 40
    mov rcx, 5
    call fact
    and rax, 255
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_10_factorial_iter_proc ENDP
main PROC
    sub     rsp, 40
    call    ex_10_factorial_iter_proc
    mov     rcx, rax
    call    ExitProcess
main ENDP

fact PROC
    mov rax, 1
    mov r8, 1
loop_start:
    cmp r8, rcx
    jg done
    imul rax, r8
    inc r8
    jmp loop_start
done:
    ret
fact ENDP
END
