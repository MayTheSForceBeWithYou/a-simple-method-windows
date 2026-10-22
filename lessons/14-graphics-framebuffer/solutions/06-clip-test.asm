; Exercise: 06-clip-test
;
; x=5 w=4 -> outside exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_06_clip_test PROC
    sub rsp, 40
    mov rax, 5
    cmp rax, 4
    jl in_range
    mov rcx, 1
    jmp exit_proc
in_range:
    xor rcx, rcx
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_clip_test ENDP
main PROC
    sub     rsp, 40
    call    ex_06_clip_test
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
