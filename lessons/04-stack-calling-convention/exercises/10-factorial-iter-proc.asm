; Exercise 10: factorial iter proc (Win32 port)
;
; fact(n) iterative as procedure. fact(5)=120; exit 120.
;
; Build: ml64 /c /Fo10-factorial-iter-proc.obj 10-factorial-iter-proc.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-factorial-iter-proc.exe 10-factorial-iter-proc.obj kernel32.lib
; Expected: exit code 120

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement iterative factorial(RCX) -> RAX

main PROC
    sub     rsp, 32
    mov rcx, 5
    call factorial
    mov rcx, rax
    call ExitProcess
main ENDP
END
