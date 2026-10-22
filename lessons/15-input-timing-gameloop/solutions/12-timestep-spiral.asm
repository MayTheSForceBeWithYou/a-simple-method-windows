; Exercise: 12-timestep-spiral
;
; Spiral of death guard: max 3 catchup steps; given 100ms dt step 16 -> would be 6, clamp 3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.code
ex_12_timestep_spiral PROC
    sub rsp, 40
    mov rax, 100
    xor rdx, rdx
    mov rbx, 16
    div rbx
    cmp rax, 3
    jbe clamp_ok
    mov rax, 3
clamp_ok:
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_12_timestep_spiral ENDP
main PROC
    sub     rsp, 40
    call    ex_12_timestep_spiral
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
