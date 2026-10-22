; Exercise: 29-from-scratch-factorial-loop
;
; FROM SCRATCH: 6! with a counted loop = 720. Exit 720&255=208.
; Expected exit: 208
;
.code
ex_29_from_scratch_factorial_loop PROC
    sub rsp, 40
    mov rax, 1
    mov r8, 2
loop_start:
    cmp r8, 6
    jg done
    imul rax, r8
    inc r8
    jmp loop_start
done:
    mov rcx, rax
    and rcx, 255
    mov     eax, ecx
    add     rsp, 40
    ret
ex_29_from_scratch_factorial_loop ENDP
main PROC
    sub     rsp, 40
    call    ex_29_from_scratch_factorial_loop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
