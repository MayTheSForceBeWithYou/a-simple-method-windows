; Exercise 07: peep happy
;
; happiness clamp 0..100; set 120->100.
;
; Build: ml64 /c 07-peep-happy.asm && link /OUT:07-peep-happy.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-peep-happy.obj kernel32.lib
;
; Expected exit: 100
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rax, 120
    cmp rax, 100
    jle clamp_ok
    mov rax, 100
clamp_ok:
    mov rcx, rax
    call ExitProcess
main ENDP
END
