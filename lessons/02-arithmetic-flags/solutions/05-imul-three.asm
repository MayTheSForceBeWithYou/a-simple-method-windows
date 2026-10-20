; Exercise 05: imul three (Win32 port) - SOLUTION
;
; RBX=14. IMUL RAX, RBX, 3. Exit with 42.
;
; Build: ml64 /c /Fo05-imul-three.obj 05-imul-three.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-imul-three.exe 05-imul-three.obj kernel32.lib
; Run: 05-imul-three.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rbx, 14
    imul rax, rbx, 3           ; RAX = 14 * 3 = 42
    mov rcx, rax
    call ExitProcess
    
main ENDP

END
