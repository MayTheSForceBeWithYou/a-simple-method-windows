; Exercise 06: mul unsigned (Win32 port)
;
; RAX=21, RBX=2. MUL RBX. Exit with quotient (42).
;
; Build: ml64 /c /Fo06-mul-unsigned.obj 06-mul-unsigned.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-mul-unsigned.exe 06-mul-unsigned.obj kernel32.lib
; Run: 06-mul-unsigned.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 21
    mov rbx, 2
    
    ; TODO: MUL RBX; exit with RAX
    .ERR <TODO: Use MUL>
    
main ENDP

END
