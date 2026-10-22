; Exercise 19: debug map bounds
;
; BUG: no bounds check. Clamp x=99 to w-1=7; exit 7.
;
; Expected exit: 7
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_19_debug_map_bounds PROC
mov rax, 99
    mov r8, 8
    cmp rax, r8
    jl bounds_ok
    mov rax, r8
    dec rax
bounds_ok:
    mov rcx, rax
    ret
ex_19_debug_map_bounds ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_map_bounds
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
