; Exercise: 18-max3-proc
;
; max3(3,9,7)=9. MS x64 ABI.
; Expected exit: 9
;
.code
ex_18_max3_proc PROC
    sub rsp, 40
    mov rcx, 3
    mov rdx, 9
    mov r8, 7
    call max3
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_18_max3_proc ENDP
main PROC
    sub     rsp, 40
    call    ex_18_max3_proc
    mov     rcx, rax
    call    ExitProcess
main ENDP

max3 PROC
    mov rax, rcx
    cmp rdx, rax
    cmovg rax, rdx
    cmp r8, rax
    cmovg rax, r8
    ret
max3 ENDP
END
