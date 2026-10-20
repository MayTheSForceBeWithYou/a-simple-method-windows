; Exercise 16: repeat delay
;
; Key repeat after 3 ticks; tick count 3 -> fire; exit 1.
;
; Build: ml64 /c 16-repeat-delay.asm && link /OUT:16-repeat-delay.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-repeat-delay.obj kernel32.lib
;
; Expected exit: 1
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
held QWORD ?

.code
main PROC
    sub rsp, 32
    mov QWORD PTR [held], 3
    cmp QWORD PTR [held], 3
    jl not_fire
    mov rcx, 1
    jmp exit_proc
not_fire:
    xor rcx, rcx
exit_proc:
    call ExitProcess
main ENDP
END
