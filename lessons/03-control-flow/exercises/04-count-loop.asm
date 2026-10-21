; Exercise 04: count loop (Win32 port)
;
; For loop from 0 to 4. Count iterations. Exit with count (5).
;
; Build: ml64 /c /Fo04-count-loop.obj 04-count-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-count-loop.exe 04-count-loop.obj kernel32.lib
; Run: 04-count-loop.exe & echo %ERRORLEVEL%
;
; Expected exit: 5
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rcx, rcx               ; Index
    xor rax, rax               ; Count
    
    ; TODO: While index < 5, inc count, inc index
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
