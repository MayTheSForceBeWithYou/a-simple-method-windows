; Exercise 21: debug fold bug
; BUG: 2*3+4 computed as 2*(3+4). Fix to 10.
; Expected exit: 10

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_debug_fold_bug:PROC

fold_bug PROC
    mov rax, 2
    mov rbx, 3
    add rbx, 4                  ; BUG: added before multiply
    imul rax, rbx
    ret
fold_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_debug_fold_bug in this file.
    call    ex_21_debug_fold_bug
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
