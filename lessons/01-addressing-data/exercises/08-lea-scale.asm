; Exercise 08: lea scale (Win32 port)
;
; Use LEA to multiply: RAX=7, compute RAX*4 with LEA RAX,[RAX*4]. Exit with 28.
;
; Build: ml64 /c /Fo08-lea-scale.obj 08-lea-scale.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-lea-scale.exe 08-lea-scale.obj kernel32.lib
; Run: 08-lea-scale.exe & echo %ERRORLEVEL%
;
; Expected: exit code 28

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 7
    
    ; TODO: LEA RAX, [RAX*4] or equivalent to multiply by 4
    ; TODO: Exit with result
    .ERR <TODO: Use LEA for arithmetic>
    
main ENDP

END
