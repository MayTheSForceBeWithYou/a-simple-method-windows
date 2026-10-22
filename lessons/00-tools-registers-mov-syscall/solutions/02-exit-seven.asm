; Exercise 02: exit seven
;
; Exit with status 7.
;
; Build: ml64 /c 02-exit-seven.asm && link /OUT:02-exit-seven.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-exit-seven.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
ex_02_exit_seven PROC
    sub rsp, 40
        mov     eax, 7
    ret

ex_02_exit_seven ENDP
main PROC
    call    ex_02_exit_seven
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
