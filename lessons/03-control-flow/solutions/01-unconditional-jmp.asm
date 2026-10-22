; Exercise 01: unconditional jmp
;
; jmp over a mov rcx,99; fallthrough sets rcx=7; exit 7.
;
; Build: ml64 /c 01-unconditional-jmp.asm && link /OUT:01-unconditional-jmp.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-unconditional-jmp.obj kernel32.lib
;
; Expected exit: 7

EXTERN ExitProcess:PROC

.code
ex_01_unconditional_jmp PROC
    sub rsp, 40
    jmp ok
    mov rcx, 99
ok:
    mov rcx, 7
    mov     eax, 7
    add     rsp, 40
    ret
ex_01_unconditional_jmp ENDP
main PROC
    sub     rsp, 40
    call    ex_01_unconditional_jmp
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
