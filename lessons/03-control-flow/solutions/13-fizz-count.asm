; Exercise: 13-fizz-count
;
; AoC-lite: count numbers 1..20 divisible by 3 (6). Exit 6.
; Expected exit: 6
;
.code
ex_13_fizz_count PROC
    sub rsp, 40
    xor rcx, rcx
    mov r8, 1
loop_start:
    cmp r8, 20
    jg done
    mov rax, r8
    xor rdx, rdx
    mov rbx, 3
    div rbx
    cmp rdx, 0
    jne next
    inc rcx
next:
    inc r8
    jmp loop_start
done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_13_fizz_count ENDP
main PROC
    sub     rsp, 40
    call    ex_13_fizz_count
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
