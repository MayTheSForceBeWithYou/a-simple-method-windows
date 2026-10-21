; Exercise 06: eax zero extends (Win32 port)
;
; Fill RAX with -1, then write 5 to EAX. Verify upper 32 bits are cleared.
; Exit with the low byte of RAX (should be 5).
;
; Build: ml64 /c /Fo06-eax-zero-extends.obj 06-eax-zero-extends.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-eax-zero-extends.exe 06-eax-zero-extends.obj kernel32.lib
; Run: 06-eax-zero-extends.exe & echo %ERRORLEVEL%
;
; Expected: exit code 5

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, -1                ; Fill RAX with all 1s
    
    ; TODO: Write 5 to EAX (which zero-extends to RAX)
    ; Then move RAX to RCX and call ExitProcess
    
main ENDP

END
