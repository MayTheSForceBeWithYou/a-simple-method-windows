; Exercise: 18-double-buffer-index
;
; Flip buffer index 0<->1; start 0 flip twice exit 0.
; Expected stdout: (none)
; Expected exit: 0
;
.data?
idx QWORD ?

.code
ex_18_double_buffer_index PROC
    sub rsp, 40
    mov QWORD PTR [idx], 0
    xor QWORD PTR [idx], 1
    xor QWORD PTR [idx], 1
    mov rcx, [idx]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_18_double_buffer_index ENDP
main PROC
    sub     rsp, 40
    call    ex_18_double_buffer_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
