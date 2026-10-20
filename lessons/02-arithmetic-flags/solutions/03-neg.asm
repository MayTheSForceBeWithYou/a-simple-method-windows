; Exercise 03: neg
;
; mov rcx, 5; neg rcx; add rcx, 10; exit (5).
;
; Build: ml64 /c 03-neg.asm && link /OUT:03-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 03-neg.obj kernel32.lib
;
; Expected exit: 5

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    mov rcx, 5
    neg rcx
    add rcx, 10
    call ExitProcess
main ENDP
END
