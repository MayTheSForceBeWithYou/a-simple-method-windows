; Exercise 01: cmp je (Win32 port)
;
; RAX=10, RBX=10. CMP and JE. If equal, exit 1; else exit 0.
;
; Build: ml64 /c /Fo01-cmp-je.obj 01-cmp-je.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-cmp-je.exe 01-cmp-je.obj kernel32.lib
; Run: 01-cmp-je.exe & echo %ERRORLEVEL%
;
; Expected exit: 1
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    mov rbx, 10
    
    ; TODO: CMP RAX, RBX; JE to set RCX=1; else RCX=0; exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
