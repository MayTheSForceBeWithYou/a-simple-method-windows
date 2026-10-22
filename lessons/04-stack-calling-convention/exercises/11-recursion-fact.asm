; Exercise 11: recursion fact (Win32 port)
; Recursive fact(4)=24. Preserve regs properly. Exit 24.
; Build: ml64 /c /Fo11-recursion-fact.obj 11-recursion-fact.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:11-recursion-fact.exe 11-recursion-fact.obj kernel32.lib
; Expected: exit code 24

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement recursive factorial with proper PROC FRAME

main PROC
    sub     rsp, 32
    mov rcx, 4
    call factorial
    mov rcx, rax
    call ExitProcess
main ENDP
END
