; Exercise 15: exit sum (Win32 port) - SOLUTION
;
; Add three numbers and exit with their sum.
;
; Build: ml64 /c /Fo15-exit-sum.obj 15-exit-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-exit-sum.exe 15-exit-sum.obj kernel32.lib
; Run: 15-exit-sum.exe & echo %ERRORLEVEL%
;
; Expected: exit code 100 (10 + 30 + 60)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    add rax, 30
    add rax, 60
    mov rcx, rax               ; Total is 100
    call ExitProcess
    
main ENDP

END
