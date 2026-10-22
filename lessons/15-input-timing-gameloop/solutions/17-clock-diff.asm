; Exercise 17: clock diff
;
; t1-t0 = 40; exit 40.
;
; Build: ml64 /c 17-clock-diff.asm && link /OUT:17-clock-diff.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-clock-diff.obj kernel32.lib
;
; Expected exit: 40
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code

ex_17_clock_diff PROC
mov rax, 100
    mov rbx, 60
    sub rax, rbx
    mov rcx, rax

    ret
ex_17_clock_diff ENDP
main PROC
    sub     rsp, 40
    call    ex_17_clock_diff
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
