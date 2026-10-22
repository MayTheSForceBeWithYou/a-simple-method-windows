; Exercise: 10-insert-middle
;
; buf "AC" len2 cur1; insert B -> "ABC"; exit middle byte 66.
; Expected exit: 66
;
.data
buf BYTE "AC", 0, 0, 0, 0

.data?
len QWORD ?
cur QWORD ?

.code
ex_10_insert_middle PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 2
    mov QWORD PTR [cur], 1
    
    ; Shift right from end
    mov rcx, [len]
    
L_shift:
    cmp rcx, [cur]
    jl L_put
    
    lea rdx, buf
    movzx rax, BYTE PTR [rdx+rcx-1]
    mov BYTE PTR [rdx+rcx], al
    
    dec rcx
    jmp L_shift
    
L_put:
    lea rdx, buf
    mov BYTE PTR [rdx+1], 'B'
    inc QWORD PTR [len]
    
    movzx rcx, BYTE PTR [rdx+1]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_10_insert_middle ENDP
main PROC
    sub     rsp, 40
    call    ex_10_insert_middle
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
