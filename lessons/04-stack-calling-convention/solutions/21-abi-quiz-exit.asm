; Exercise 21: abi quiz exit
;
; MS x64: args in rcx,rdx,r8,r9. identity4 returns arg4 (r9). Exit 4.
;
; Expected exit: 4
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_21_abi_quiz_exit PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 1
    mov rdx, 2
    mov r8, 3
    mov r9, 4
    call identity4
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_21_abi_quiz_exit ENDP
main PROC
    sub     rsp, 40
    call    ex_21_abi_quiz_exit
    mov     rcx, rax
    call    ExitProcess
main ENDP

identity4 PROC
    mov rax, r9
    ret
identity4 ENDP
END
