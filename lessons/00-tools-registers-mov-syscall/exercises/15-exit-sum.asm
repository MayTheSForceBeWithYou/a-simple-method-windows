; Exercise 15: exit sum (Win32 port)
;
; Add three numbers and exit with their sum.
;
; Build: ml64 /c /Fo15-exit-sum.obj 15-exit-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-exit-sum.exe 15-exit-sum.obj kernel32.lib
; Run: 15-exit-sum.exe & echo %ERRORLEVEL%
;
; Expected exit: 100 (10 + 30 + 60)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    ; TODO: Add 30 to RAX
    ; TODO: Add 60 to RAX
    ; TODO: Move result to RCX and exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
