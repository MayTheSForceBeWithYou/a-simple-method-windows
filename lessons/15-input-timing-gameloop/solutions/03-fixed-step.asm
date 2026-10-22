; Exercise 03: fixed step
;
; step=16ms units; 50ms -> 3 steps; exit 3.
;
; Build: ml64 /c 03-fixed-step.asm && link /OUT:03-fixed-step.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-fixed-step.obj kernel32.lib
;
; Expected exit: 3
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_03_fixed_step PROC
    sub rsp, 40
    mov rax, 50
    xor rdx, rdx
    mov rbx, 16
    div rbx
        add     rsp, 40
        ret
ex_03_fixed_step ENDP
main PROC
    sub     rsp, 40
    call    ex_03_fixed_step
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
