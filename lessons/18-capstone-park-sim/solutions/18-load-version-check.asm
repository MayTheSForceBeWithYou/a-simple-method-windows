; Exercise 18: load version check
;
; version==1 ok exit 1.
;
; Build: ml64 /c 18-load-version-check.asm && link /OUT:18-load-version-check.exe /ENTRY:main /SUBSYSTEM:CONSOLE 18-load-version-check.obj kernel32.lib
;

EXTERN ExitProcess:PROC

.code
    
main PROC
    sub rsp, 32
    cmp qword [ver],1
    jne .n
    mov rdi,1
    jmp .o
.n:
    xor rdi,rdi
.o:
    mov rax,60
    syscall

main ENDP
END
