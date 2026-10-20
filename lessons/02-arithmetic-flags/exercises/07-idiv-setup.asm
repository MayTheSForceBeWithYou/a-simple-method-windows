; Exercise 07: idiv setup (Win32 port)
;
; RAX=126, divisor=3. Use CQO and IDIV. Exit with quotient (42).
;
; Build: ml64 /c /Fo07-idiv-setup.obj 07-idiv-setup.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-idiv-setup.exe 07-idiv-setup.obj kernel32.lib
; Run: 07-idiv-setup.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 126
    mov rbx, 3
    
    ; TODO: CQO to sign-extend, IDIV RBX, exit with quotient
    .ERR <TODO: Use CQO and IDIV>
    
main ENDP

END
