; Exercise 10: cmp setne (Win32 port)
;
; RAX=10, RBX=20. CMP and SETNE. Exit with 1 (not equal).
;
; Build: ml64 /c /Fo10-cmp-setne.obj 10-cmp-setne.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-cmp-setne.exe 10-cmp-setne.obj kernel32.lib
; Run: 10-cmp-setne.exe & echo %ERRORLEVEL%
;
; Expected: exit code 1

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 10
    mov rbx, 20
    
    ; TODO: CMP RAX, RBX; SETNE CL; MOVZX RCX, CL; exit
    .ERR <TODO: Use CMP and SETNE>
    
main ENDP

END
