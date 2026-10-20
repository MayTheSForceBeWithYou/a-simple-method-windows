; Exercise 01: add sub
;
; rcx=100; add 20; sub 78; exit (42).
;
; Build: ml64 /c 01-add-sub.asm && link /OUT:01-add-sub.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-add-sub.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 100
    add rcx, 20
    sub rcx, 78
    call ExitProcess
main ENDP
END
