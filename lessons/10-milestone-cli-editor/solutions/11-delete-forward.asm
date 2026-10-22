; Exercise: 11-delete-forward
;
; "ABCD" cur=1 delete -> "ACD"; len=3 exit 3.
; Expected exit: 3
;
.data
buf BYTE "ABCD", 0

.data?
len QWORD ?
cur QWORD ?

.code
ex_11_delete_forward PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 4
    mov QWORD PTR [cur], 1
    
    mov rcx, [cur]
    lea rdx, buf
    
L_l:
    mov rax, rcx
    inc rax
    cmp rax, [len]
    jge L_fin
    
    movzx r8, BYTE PTR [rdx+rcx+1]
    mov BYTE PTR [rdx+rcx], r8b
    
    inc rcx
    jmp L_l
    
L_fin:
    dec QWORD PTR [len]
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_11_delete_forward ENDP
main PROC
    sub     rsp, 40
    call    ex_11_delete_forward
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
