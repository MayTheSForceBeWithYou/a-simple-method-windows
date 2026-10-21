; Exercise 06: prologue locals (Win32 port)
;
; Function stores local = RCX+1 on stack frame; returns it. Call with 41; exit 42.
;
; Build: ml64 /c /Fo06-prologue-locals.obj 06-prologue-locals.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-prologue-locals.exe 06-prologue-locals.obj kernel32.lib
; Expected: exit code 42

.CODE
EXTRN ExitProcess:PROC

; TODO: Implement function with local variable on stack

main PROC
    sub rsp, 32
    mov rcx, 41
    call compute_plus_one
    mov rcx, rax
    call ExitProcess
main ENDP
END
