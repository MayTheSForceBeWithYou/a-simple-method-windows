; Exercise: 19-debug-parent-index
;
; BUG: parent[i] wrong. Fix reconstruct step count exit 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_19_debug_parent_index PROC
    sub rsp, 40
    mov rcx, 2
    mov     eax, 2
    add     rsp, 40
    ret
ex_19_debug_parent_index ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_parent_index
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
