; Exercise 16: mov imm vs reg
;
; Load 100 into rax (imm), copy to rbx, copy rbx to rcx, exit.
;
; Build: ml64 /c 16-mov-imm-vs-reg.asm && link /OUT:16-mov-imm-vs-reg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-mov-imm-vs-reg.obj kernel32.lib
;
; Expected exit: 100

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 100
    mov rbx, rax
    mov rcx, rbx
    call ExitProcess
main ENDP
END
