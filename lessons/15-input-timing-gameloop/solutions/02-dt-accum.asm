; Exercise: 02-dt-accum
;
; accum+=dt; if >= step then tick++; exit ticks 2 for accum sim.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_02_dt_accum PROC
    sub rsp, 40
    xor rcx, rcx
    mov rax, 0
    add rax, 8
    add rax, 8
    mov rbx, 8
loop_start:
    cmp rax, rbx
    jl loop_done
    sub rax, rbx
    inc rcx
    jmp loop_start
loop_done:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_02_dt_accum ENDP
main PROC
    sub     rsp, 40
    call    ex_02_dt_accum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
