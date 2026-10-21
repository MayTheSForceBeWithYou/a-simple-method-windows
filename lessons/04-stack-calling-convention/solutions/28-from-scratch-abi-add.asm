; Exercise 28: from scratch abi add
;
; FROM SCRATCH: add3(a,b,c) = a+b+c with MS x64 regs; exit 42 for 10,20,12.
;
; Expected exit: 42
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC FRAME
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    mov rcx, 10
    mov rdx, 20
    mov r8, 12
    call add3
    mov rcx, rax
    call ExitProcess
main ENDP

add3 PROC
    mov rax, rcx
    add rax, rdx
    add rax, r8
    ret
add3 ENDP
END
