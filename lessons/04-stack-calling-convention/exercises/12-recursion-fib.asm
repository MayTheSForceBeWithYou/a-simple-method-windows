; Exercise 12: recursion fib (Win32 port)
; Naive fib(7)=13. Exit 13. (OK if slow.)
; Build: ml64 /c /Fo12-recursion-fib.obj 12-recursion-fib.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:12-recursion-fib.exe 12-recursion-fib.obj kernel32.lib
; Expected: exit code 13

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive fibonacci with PROC FRAME

main PROC
    sub rsp, 32
    mov rcx, 7
    call fibonacci
    mov rcx, rax
    call ExitProcess
main ENDP
END
