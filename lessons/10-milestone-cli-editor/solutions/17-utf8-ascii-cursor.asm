; Exercise: 17-utf8-ascii-cursor
;
; ASCII-only: moving right increments cursor by 1; exit 5 after 5 moves.
; Expected exit: 5
;
.data?
cur QWORD ?

.code
ex_17_utf8_ascii_cursor PROC
    sub rsp, 40
    
    mov QWORD PTR [cur], 0
    mov rcx, 5
    
L_l:
    inc QWORD PTR [cur]
    loop L_l
    
    mov rcx, [cur]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_17_utf8_ascii_cursor ENDP
main PROC
    sub     rsp, 40
    call    ex_17_utf8_ascii_cursor
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
