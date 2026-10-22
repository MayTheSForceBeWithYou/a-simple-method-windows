; Exercise: 01-data-dq
;
; Define count QWORD 41 in .data. Load into rcx, add 1, exit (42).
; Expected exit: 42
;
.data
count QWORD 41

.code
ex_01_data_dq PROC
    sub rsp, 40
    mov rcx, [count]
    add rcx, 1
    mov     eax, ecx
    add     rsp, 40
    ret
ex_01_data_dq ENDP
main PROC
    sub     rsp, 40
    call    ex_01_data_dq
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
