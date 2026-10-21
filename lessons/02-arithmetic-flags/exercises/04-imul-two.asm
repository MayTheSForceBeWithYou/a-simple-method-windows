; Exercise 04: imul two (Win32 port)
;
; RAX=6, RBX=7. IMUL RAX, RBX. Exit with 42.
;
; Build: ml64 /c /Fo04-imul-two.obj 04-imul-two.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-imul-two.exe 04-imul-two.obj kernel32.lib
; Run: 04-imul-two.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 6
    mov rbx, 7
    
    ; TODO: IMUL RAX, RBX; exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
