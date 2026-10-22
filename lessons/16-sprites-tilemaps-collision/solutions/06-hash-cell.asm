; Exercise: 06-hash-cell
;
; cell=(x>>3)+((y>>3)<<4); x=10 y=10; compute exit &255.
; Expected stdout: (none)
; Expected exit: 17
;
.code
ex_06_hash_cell PROC
    sub rsp, 40
    mov rax, 10
    shr rax, 3
    mov rbx, 10
    shr rbx, 3
    shl rbx, 4
    add rax, rbx
    and rax, 255
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_06_hash_cell ENDP
main PROC
    sub     rsp, 40
    call    ex_06_hash_cell
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
