; Exercise: 16-gap-move-left
;
; Move gap left: gap_s=3 gap_e=5 -> move left once gap_s=2 gap_e=4; exit gap_s.
; Expected exit: 2
;
.data?
gap_s QWORD ?
gap_e QWORD ?

.code
ex_16_gap_move_left PROC
    sub rsp, 40
    
    mov QWORD PTR [gap_s], 3
    mov QWORD PTR [gap_e], 5
    
    dec QWORD PTR [gap_s]
    dec QWORD PTR [gap_e]
    
    mov rcx, [gap_s]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_gap_move_left ENDP
main PROC
    sub     rsp, 40
    call    ex_16_gap_move_left
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
