; Exercise: 23-sib-full
;
; base=addr of table, index=2, scale=8, disp=0. table QWORD 0,0,42,0. Load into rcx.
; Expected exit: 42
;
.data
table QWORD 0, 0, 42, 0

.code
ex_23_sib_full PROC
    sub rsp, 40
    lea rbx, [table]
    mov r8, 2
    mov rcx, QWORD PTR [rbx+r8*8]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_sib_full ENDP
main PROC
    sub     rsp, 40
    call    ex_23_sib_full
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
