; Exercise 21: scenario goal
;
; Guests>=100 goal; guests=100; exit 1 success.
;
; Build: ml64 /c 21-scenario-goal.asm && link /OUT:21-scenario-goal.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-scenario-goal.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    mov qword [guests],100
    cmp qword [guests],100
    jl .n
    mov rdi,1
    jmp .o
.n:
    xor rdi,rdi
.o:
    mov rax,60
    syscall

main ENDP
END
