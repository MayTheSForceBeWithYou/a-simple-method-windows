; Exercise 03: econ tick
;
; cash+=5; exit cash 5.
;
; Build: ml64 /c 03-econ-tick.asm && link /OUT:03-econ-tick.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-econ-tick.obj kernel32.lib
;
; Expected exit: 5
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.data?
cash QWORD ?

.code
ex_03_econ_tick PROC
    sub rsp, 40
    add QWORD PTR [cash], 5
        mov     eax, [cash]
    add     rsp, 40
    ret
ex_03_econ_tick ENDP
main PROC
    sub     rsp, 40
    call    ex_03_econ_tick
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
