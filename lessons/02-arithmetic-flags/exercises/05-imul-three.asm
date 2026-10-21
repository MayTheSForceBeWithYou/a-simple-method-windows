; Exercise 05: imul three (Win32 port)
;
; RBX=14. IMUL RAX, RBX, 3. Exit with 42.
;
; Build: ml64 /c /Fo05-imul-three.obj 05-imul-three.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-imul-three.exe 05-imul-three.obj kernel32.lib
; Run: 05-imul-three.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rbx, 14
    
    ; TODO: IMUL RAX, RBX, 3; exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
