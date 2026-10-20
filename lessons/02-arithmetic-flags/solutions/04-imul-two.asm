; Exercise 04: imul two (Win32 port) - SOLUTION
;
; RAX=6, RBX=7. IMUL RAX, RBX. Exit with 42.
;
; Build: ml64 /c /Fo04-imul-two.obj 04-imul-two.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-imul-two.exe 04-imul-two.obj kernel32.lib
; Run: 04-imul-two.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 6
    mov rbx, 7
    imul rax, rbx              ; RAX = 6 * 7 = 42
    mov rcx, rax
    call ExitProcess
    
main ENDP

END
