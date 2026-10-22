; Exercise: 03-cursor-move
;
; cursor; move right then left; exit cursor 0.
; Expected exit: 0
;
.data?
cursor QWORD ?

.code
ex_03_cursor_move PROC
    sub rsp, 40
    
    mov QWORD PTR [cursor], 0
    inc QWORD PTR [cursor]
    dec QWORD PTR [cursor]
    
    mov rcx, [cursor]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_cursor_move ENDP
main PROC
    sub     rsp, 40
    call    ex_03_cursor_move
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
