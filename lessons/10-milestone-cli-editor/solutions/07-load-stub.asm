; Exercise 07: load stub
;
; Pretend load sets len=3; exit 3.
;
; Build: ml64 /c 07-load-stub.asm && link /OUT:07-load-stub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-load-stub.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
len QWORD ?

.code

ex_07_load_stub PROC
mov QWORD PTR [len], 3
    mov rcx, [len]
    mov     eax, [len]
    ret
ex_07_load_stub ENDP
main PROC
    sub     rsp, 40
    call    ex_07_load_stub
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
