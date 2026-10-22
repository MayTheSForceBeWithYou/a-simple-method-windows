; Exercise 15: exit sum
;
; Set r8=10, r9=20, r10=12. Sum into rcx; exit (42).
;
; Build: ml64 /c 15-exit-sum.asm && link /OUT:15-exit-sum.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-exit-sum.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
ex_15_exit_sum PROC
    sub rsp, 40
    mov r8, 10
    mov r9, 20
    mov r10, 12
    mov rcx, r8
    add rcx, r9
    add rcx, r10
    mov     eax, 42
    add     rsp, 40
    ret
ex_15_exit_sum ENDP
main PROC
    sub     rsp, 40
    call    ex_15_exit_sum
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
