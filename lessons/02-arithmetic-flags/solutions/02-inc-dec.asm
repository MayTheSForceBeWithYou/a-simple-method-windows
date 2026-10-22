; Exercise 02: inc dec
;
; rax=5; inc; inc; dec; mov rcx,rax; exit (6).
;
; Build: ml64 /c 02-inc-dec.asm && link /OUT:02-inc-dec.exe /ENTRY:main /SUBSYSTEM:CONSOLE 02-inc-dec.obj kernel32.lib
;
; Expected exit: 6

EXTERN ExitProcess:PROC

.code

ex_02_inc_dec PROC
mov rax, 5
    inc rax
    inc rax
    dec rax
    mov rcx, rax

    ret
ex_02_inc_dec ENDP
main PROC
    sub     rsp, 40
    call    ex_02_inc_dec
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
