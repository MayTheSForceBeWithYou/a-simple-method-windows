; Exercise 08: from scratch const fold
;
; FROM SCRATCH: fold (1+2)*3 exit 9.
; Expected exit: 9

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov rax, 1
    add rax, 2
    imul rax, 3
    mov rcx, rax
    call ExitProcess
main ENDP
END
