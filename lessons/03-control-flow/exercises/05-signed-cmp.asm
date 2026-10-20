; Exercise 05: signed cmp (Win32 port)
;
; RAX=-5, RBX=3. Signed comparison: if RAX < RBX, exit 1; else exit 0.
;
; Build: ml64 /c /Fo05-signed-cmp.obj 05-signed-cmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-signed-cmp.exe 05-signed-cmp.obj kernel32.lib
; Run: 05-signed-cmp.exe & echo %ERRORLEVEL%
;
; Expected: exit code 1

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -5
    mov rbx, 3
    
    ; TODO: CMP RAX, RBX; JL (less, signed); set RCX=1; else 0
    .ERR <TODO: Use signed comparison JL>
    
main ENDP

END
