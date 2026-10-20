; Exercise 03: exit from register (Win32 port) - SOLUTION
;
; Put 42 into RAX, then move it to the correct register for ExitProcess.
;
; Build: ml64 /c /Fo03-exit-from-register.obj 03-exit-from-register.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-exit-from-register.exe 03-exit-from-register.obj kernel32.lib
; Run: 03-exit-from-register.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 42
    mov rcx, rax               ; ExitProcess takes argument in RCX
    call ExitProcess
    
main ENDP

END
