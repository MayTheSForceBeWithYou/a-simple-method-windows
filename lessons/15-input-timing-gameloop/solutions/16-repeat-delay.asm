; Exercise: 16-repeat-delay
;
; Key repeat after 3 ticks; tick count 3 -> fire; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
held QWORD ?

.code
ex_16_repeat_delay PROC
    sub rsp, 40
    mov QWORD PTR [held], 3
    cmp QWORD PTR [held], 3
    jl not_fire
    mov rcx, 1
    jmp exit_proc
not_fire:
    xor rcx, rcx
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_repeat_delay ENDP
main PROC
    sub     rsp, 40
    call    ex_16_repeat_delay
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
