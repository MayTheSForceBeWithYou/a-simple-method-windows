; Exercise 01: add sub
;
; rcx=100; add 20; sub 78; exit (42).
;
; Build: ml64 /c 01-add-sub.asm && link /OUT:01-add-sub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-add-sub.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code

ex_01_add_sub PROC
mov rcx, 100
    add rcx, 20
    sub rcx, 78
    mov     eax, ecx
    ret
ex_01_add_sub ENDP
main PROC
    sub     rsp, 40
    call    ex_01_add_sub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
