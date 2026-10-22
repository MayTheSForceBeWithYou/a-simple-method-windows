; Exercise: 12-debug-off-by-scale
;
; BUG: array of qwords indexed with *1 instead of *8. Fix; load index 1 value 20, exit.
; Expected exit: 20
;
.data
arr QWORD 10, 20, 30

.code
ex_12_debug_off_by_scale PROC
    sub rsp, 40
    mov r8, 1
    lea r11, [arr]
    mov rcx, QWORD PTR [r11+r8*8]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_debug_off_by_scale ENDP
main PROC
    sub     rsp, 40
    call    ex_12_debug_off_by_scale
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
