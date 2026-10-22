; Exercise: 08-from-scratch-tick
;
; FROM SCRATCH: sim_tick counter to 5; exit 5.
; Expected stdout: (none)
; Expected exit: 5
;
.data?
tick QWORD ?

.code
ex_08_from_scratch_tick PROC
    sub rsp, 40
tick_loop:
    cmp QWORD PTR [tick], 5
    jge tick_done
    inc QWORD PTR [tick]
    jmp tick_loop
tick_done:
    mov rcx, [tick]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_08_from_scratch_tick ENDP
main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_tick
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
