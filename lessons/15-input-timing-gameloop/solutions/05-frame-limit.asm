; Exercise: 05-frame-limit
;
; If frame_time < min, pad; return pad amount 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_05_frame_limit PROC
    sub rsp, 40
    mov rax, 6
    mov rbx, 8
    cmp rax, rbx
    jge nopad
    mov rcx, rbx
    sub rcx, rax
    jmp exit_proc
nopad:
    xor rcx, rcx
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_05_frame_limit ENDP
main PROC
    sub     rsp, 40
    call    ex_05_frame_limit
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
