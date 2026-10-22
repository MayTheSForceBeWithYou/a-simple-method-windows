; Exercise 01: exit zero
;
; Exit with status 0 using ExitProcess.
;
; Build: ml64 /c 01-exit-zero.asm && link /OUT:01-exit-zero.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-exit-zero.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

.code
ex_01_exit_zero PROC
    sub rsp, 40
    mov rcx, 0
    mov     eax, 0
    add     rsp, 40
    ret
ex_01_exit_zero ENDP
main PROC
    sub     rsp, 40
    call    ex_01_exit_zero
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
