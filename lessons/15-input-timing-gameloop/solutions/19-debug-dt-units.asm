; Exercise: 19-debug-dt-units
;
; BUG: mixed ms/us. Fix treat 16000us as 16ms steps of 16 -> 1 step; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_19_debug_dt_units PROC
    sub rsp, 40
    mov rax, 16000
    xor rdx, rdx
    mov rbx, 1000
    div rbx
    xor rdx, rdx
    mov rbx, 16
    div rbx
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_19_debug_dt_units ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_dt_units
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
