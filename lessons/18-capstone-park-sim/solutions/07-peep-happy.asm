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
ex_07_peep_happy PROC
    sub rsp, 40
    mov rax, 120
    cmp rax, 100
    jle clamp_ok
    mov rax, 100
clamp_ok:
        mov     eax, ecx
    add     rsp, 40
    ret
ex_07_peep_happy ENDP
main PROC
    sub     rsp, 40
    call    ex_07_peep_happy
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
