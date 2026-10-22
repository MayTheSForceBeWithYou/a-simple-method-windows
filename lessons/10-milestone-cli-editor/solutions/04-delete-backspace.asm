; Exercise: 04-delete-backspace
;
; len=2; backspace; exit len 1.
; Expected exit: 1
;
.data?
len QWORD ?

.code
ex_04_delete_backspace PROC
    sub rsp, 40
    
    mov QWORD PTR [len], 2
    cmp QWORD PTR [len], 0
    je L_o
    dec QWORD PTR [len]
    
L_o:
    mov rcx, [len]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_delete_backspace ENDP
main PROC
    sub     rsp, 40
    call    ex_04_delete_backspace
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
