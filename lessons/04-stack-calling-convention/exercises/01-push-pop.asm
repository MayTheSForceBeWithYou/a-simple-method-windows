; Exercise 01: push pop (Win32 port)
;
; Push 42 onto stack, push 99, pop both in reverse order, exit with first value (42).
;
; Build: ml64 /c /Fo01-push-pop.obj 01-push-pop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-push-pop.exe 01-push-pop.obj kernel32.lib
; Expected exit: 42
; Expected stdout: (none)
.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; TODO: PUSH 42, PUSH 99, POP to RBX, POP to RCX, exit with RCX
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP
END
