; Exercise 20: fold list
; Null-terminated list [3,4,5,0]. fold_add = 12.
; Expected exit: 12

EXTERN ExitProcess:PROC

.data
lst QWORD 3,4,5,0

.code
main PROC
    sub rsp, 40
    lea rcx, lst
    call fold_add
    mov rcx, rax
    call ExitProcess
main ENDP

fold_add PROC
    xor rax, rax
loop_fold:
    mov rdx, QWORD PTR [rcx]
    test rdx, rdx
    jz done_fold
    add rax, rdx
    add rcx, 8
    jmp loop_fold
done_fold:
    ret
fold_add ENDP
END
