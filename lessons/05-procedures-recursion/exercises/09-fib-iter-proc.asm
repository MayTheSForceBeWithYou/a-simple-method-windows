; Exercise 09: fib iter proc (Win32 port)
; Iterative fib(n) as procedure. fib(10)=55; exit 55.
; Build: ml64 /c /Fo09-fib-iter-proc.obj 09-fib-iter-proc.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-fib-iter-proc.exe 09-fib-iter-proc.obj kernel32.lib
; Expected: exit code 55

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement iterative fibonacci

main PROC
    sub     rsp, 32
    mov rcx, 10
    call fib
    mov rcx, rax
    call ExitProcess
main ENDP
END
