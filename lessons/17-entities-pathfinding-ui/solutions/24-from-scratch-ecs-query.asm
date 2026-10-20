; Exercise 24: from scratch ecs query
;
; FROM SCRATCH: count entities with mask POS; 3 of 4; exit 3.
;
; Build: ml64 /c 24-from-scratch-ecs-query.asm && link /OUT:24-from-scratch-ecs-query.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-ecs-query.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    xor rdi,rdi
    xor rcx,rcx
.l:
    cmp rcx,4
    jge .d
    movzx rax,byte [masks+rcx]
    test rax,1
    jz .n
    inc rdi
.n:
    inc rcx
    jmp .l
.d:
    mov rax,60
    syscall

main ENDP
END
