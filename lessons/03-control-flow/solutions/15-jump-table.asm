; Exercise: 15-jump-table
;
; rax=1. Jump table of 3 cases setting rcx to 10/20/30. Exit 20.
; Expected exit: 20
;
.code
ex_15_jump_table PROC
    sub rsp, 40
    mov rax, 1
    lea rdx, [jt]
    jmp QWORD PTR [rdx+rax*8]
case0::
    mov rcx, 10
    jmp done
case1::
    mov rcx, 20
    jmp done
case2::
    mov rcx, 30
done:
    mov     eax, ecx
    add     rsp, 40
    ret
jt QWORD case0, case1, case2
ex_15_jump_table ENDP
main PROC
    sub     rsp, 40
    call    ex_15_jump_table
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
