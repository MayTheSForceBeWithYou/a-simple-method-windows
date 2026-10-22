; Exercise 19: debug parent index
; BUG: parent[i] wrong. Fix reconstruct step count exit 2.
; Expected exit: 2

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_parent_index:PROC

parent_steps_bug PROC
    mov rax, 1                  ; BUG: should be 2 steps
    ret
parent_steps_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_parent_index in this file.
    call    ex_19_debug_parent_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
