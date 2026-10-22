; Exercise: 04-agent-step
;
; agent x++; exit x.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
ax_ QWORD ?

.code
ex_04_agent_step PROC
    sub rsp, 40
    inc QWORD PTR [ax_]
    mov rcx, [ax_]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_04_agent_step ENDP
main PROC
    sub     rsp, 40
    call    ex_04_agent_step
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
