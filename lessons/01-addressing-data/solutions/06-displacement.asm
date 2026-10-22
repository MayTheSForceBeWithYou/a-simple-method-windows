; Exercise: 06-displacement
;
; struct-like: base label vals with QWORD 1,2,3. Load third qword via [vals+16] into rcx, exit.
; Expected exit: 3
;
.data
vals QWORD 1, 2, 3

.code
ex_06_displacement PROC
    sub rsp, 40
    mov rcx, QWORD PTR [vals+16]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_06_displacement ENDP
main PROC
    sub     rsp, 40
    call    ex_06_displacement
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
