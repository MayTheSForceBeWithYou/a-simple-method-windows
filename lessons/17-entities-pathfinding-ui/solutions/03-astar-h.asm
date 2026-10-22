; Exercise: 03-astar-h
;
; Manhattan |3-1|+|4-2|=4.
; Expected stdout: (none)
; Expected exit: 4
;
.code
ex_03_astar_h PROC
    sub rsp, 40
    mov rax, 3
    sub rax, 1
    mov rbx, 4
    sub rbx, 2
    add rax, rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_03_astar_h ENDP
main PROC
    sub     rsp, 40
    call    ex_03_astar_h
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
