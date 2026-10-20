; Exercise 02: if else (Win32 port)
;
; RAX=5. If RAX < 10, exit 20; else exit 30.
;
; Build: ml64 /c /Fo02-if-else.obj 02-if-else.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-if-else.exe 02-if-else.obj kernel32.lib
; Run: 02-if-else.exe & echo %ERRORLEVEL%
;
; Expected: exit code 20

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 5
    
    ; TODO: CMP RAX, 10; use JGE for else branch; set RCX appropriately
    .ERR <TODO: Implement if-else>
    
main ENDP

END
