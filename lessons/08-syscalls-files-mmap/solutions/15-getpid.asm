; Exercise 15: getpid
;
; GetCurrentProcessId; exit 0 if the pid is nonzero, else 1.
;
; Build: ml64 /c 15-getpid.asm && link /OUT:15-getpid.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-getpid.obj kernel32.lib
;
; Expected exit: 0

EXTERN GetCurrentProcessId:PROC
EXTERN ExitProcess:PROC

.code
ex_15_getpid PROC
    sub rsp, 40
    
    call GetCurrentProcessId
    test rax, rax
    setz cl
    movzx rcx, cl
    mov     eax, 0
    add     rsp, 40
    ret
ex_15_getpid ENDP
main PROC
    call    ex_15_getpid
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
