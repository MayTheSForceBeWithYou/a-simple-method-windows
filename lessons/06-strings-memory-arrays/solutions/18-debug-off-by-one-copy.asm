; Exercise 18: debug off by one copy
;
; BUG: copies n bytes but forgets NUL. Fix strcpy of "ok"; strlen=2.
;
; Expected exit: 2
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data
src BYTE "ok", 0

.data?
dst BYTE 8 DUP(?)

.code
ex_18_debug_off_by_one_copy PROC
    sub rsp, 40
    .ALLOCSTACK 40
    .ENDPROLOG
    lea rcx, dst
    lea rdx, src
    call strcpy
    lea rcx, dst
    call strlen_fn
        mov     eax, rax
    ret

ex_18_debug_off_by_one_copy ENDP
main PROC
    call    ex_18_debug_off_by_one_copy
    mov     rcx, rax
    call    ExitProcess
main ENDP

strcpy PROC
cpy_loop:
    mov al, BYTE PTR [rdx]
    mov BYTE PTR [rcx], al
    inc rdx
    inc rcx
    test al, al
    jnz cpy_loop
    ret
strcpy ENDP

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
