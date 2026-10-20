; Exercise 09: cmp sete (Win32 port) - SOLUTION
;
; RAX=42, RBX=42. CMP and SETE. Exit with 1 (true).
;
; Build: ml64 /c /Fo09-cmp-sete.obj 09-cmp-sete.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-cmp-sete.exe 09-cmp-sete.obj kernel32.lib
; Run: 09-cmp-sete.exe & echo %ERRORLEVEL%
;
; Expected: exit code 1

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 42
    mov rbx, 42
    cmp rax, rbx               ; Compare, sets ZF=1 (equal)
    sete cl                    ; CL = 1 if equal
    movzx rcx, cl
    call ExitProcess
    
main ENDP

END
