; Exercise 20: max via flags
;
; a=17,b=23 in regs. cmp; use cmovg to put max in rcx. Exit 23.
;
; Build: ml64 /c 20-max-via-flags.asm && link /OUT:20-max-via-flags.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-max-via-flags.obj kernel32.lib
;
; Expected exit: 23

EXTERN ExitProcess:PROC

.code
ex_20_max_via_flags PROC
    sub rsp, 40
    mov rax, 17
    mov rbx, 23
    mov rcx, rax
    cmp rbx, rcx
    cmovg rcx, rbx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_20_max_via_flags ENDP
main PROC
    sub     rsp, 40
    call    ex_20_max_via_flags
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
