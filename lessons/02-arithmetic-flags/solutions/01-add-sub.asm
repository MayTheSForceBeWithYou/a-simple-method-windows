; Exercise 01: add sub (Win32 port) - SOLUTION
;
; RAX=100; add 20; sub 78; exit (42).
;
; Build: ml64 /c /Fo01-add-sub.obj 01-add-sub.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-add-sub.exe 01-add-sub.obj kernel32.lib
; Run: 01-add-sub.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 100
    add rax, 20                ; RAX = 120
    sub rax, 78                ; RAX = 42
    mov rcx, rax
    call ExitProcess
    
main ENDP

END
