; Exercise 13: astar fscore
;
; f=g+h; g=3 h=4; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_13_astar_fscore PROC
mov rcx, 3
    add rcx, 4
    mov     eax, ecx
    ret
ex_13_astar_fscore ENDP
main PROC
    sub     rsp, 40
    call    ex_13_astar_fscore
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
