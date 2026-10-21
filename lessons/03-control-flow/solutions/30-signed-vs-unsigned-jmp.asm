; Exercise 30: signed vs unsigned jmp
;
; rax=0xFFFFFFFFFFFFFFFF (-1 signed), cmp to 1. Using jl should take less path exit 1; document why ja would not.
;
; Build: ml64 /c 30-signed-vs-unsigned-jmp.asm && link /OUT:30-signed-vs-unsigned-jmp.exe /ENTRY:main /SUBSYSTEM:CONSOLE 30-signed-vs-unsigned-jmp.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, -1
    cmp rax, 1
    jl less
    mov rcx, 0
    jmp L_done
less:
    mov rcx, 1
L_done:
    call ExitProcess
main ENDP
END
