; Exercise 17: bounded strcpy
;
; Copy at most 3 chars + NUL from "abcdef" into 4-byte dst; strlen dst=3.
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
src BYTE "abcdef", 0

.data?
dst BYTE 4 DUP(?)

.code
ex_17_bounded_strcpy PROC
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, dst
    lea rdx, src
    mov r8, 3
    call strncpy_term
    lea rcx, dst
    call strlen_fn
        add     rsp, 40
        ret
ex_17_bounded_strcpy ENDP
main PROC
    sub     rsp, 40
    call    ex_17_bounded_strcpy
    mov     rcx, rax
    call    ExitProcess
main ENDP

strncpy_term PROC
    xor r9, r9
cpy_loop:
    cmp r9, r8
    jge cpy_nul
    mov al, BYTE PTR [rdx+r9]
    mov BYTE PTR [rcx+r9], al
    test al, al
    jz cpy_done
    inc r9
    jmp cpy_loop
cpy_nul:
    mov BYTE PTR [rcx+r8], 0
cpy_done:
    ret
strncpy_term ENDP

strlen_fn PROC
    mov rax, rcx
len_loop:
    cmp BYTE PTR [rax], 0
    je len_done
    inc rax
    jmp len_loop
len_done:
    sub rax, rcx
    ret
strlen_fn ENDP
END
