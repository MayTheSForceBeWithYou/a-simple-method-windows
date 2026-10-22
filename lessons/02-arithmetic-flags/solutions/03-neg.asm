; Exercise 03: neg
;
; mov rcx, 5; neg rcx; add rcx, 10; exit (5).
;
; Build: ml64 /c 03-neg.asm && link /OUT:03-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-neg.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.code

ex_03_neg PROC
sub rsp, 40
    mov rcx, 5
    neg rcx
    add rcx, 10
    mov     eax, 5
    ret
ex_03_neg ENDP
main PROC
    sub     rsp, 40
    call    ex_03_neg
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
