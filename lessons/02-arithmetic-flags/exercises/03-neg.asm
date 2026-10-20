; Exercise 03: neg (Win32 port)
;
; RAX=-42; negate it; exit (42).
;
; Build: ml64 /c /Fo03-neg.obj 03-neg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-neg.exe 03-neg.obj kernel32.lib
; Run: 03-neg.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -42
    
    ; TODO: NEG RAX, exit
    .ERR <TODO: Negate and exit>
    
main ENDP

END
