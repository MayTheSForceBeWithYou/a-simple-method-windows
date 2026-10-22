; Exercise 23: stretch factorial5
;
; STRETCH: 5! = 120 using successive imul. Exit 120.
;
; Build: ml64 /c 23-stretch-factorial5.asm && link /OUT:23-stretch-factorial5.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-stretch-factorial5.obj kernel32.lib
;
; Expected exit: 120

EXTERN ExitProcess:PROC

.code
ex_23_stretch_factorial5 PROC
    sub rsp, 40
    mov rax, 1
    imul rax, 2
    imul rax, 3
    imul rax, 4
    imul rax, 5
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_23_stretch_factorial5 ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_factorial5
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
