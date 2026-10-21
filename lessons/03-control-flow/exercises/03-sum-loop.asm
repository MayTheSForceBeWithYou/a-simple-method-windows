; Exercise 03: sum loop (Win32 port)
;
; Sum numbers 1 to 10 with a while loop. Exit with sum (55).
;
; Build: ml64 /c /Fo03-sum-loop.obj 03-sum-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-sum-loop.exe 03-sum-loop.obj kernel32.lib
; Run: 03-sum-loop.exe & echo %ERRORLEVEL%
;
; Expected exit: 55
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    xor rax, rax               ; Sum
    mov rcx, 10                ; Counter
    
    ; TODO: While loop: add rcx to rax, dec rcx, repeat until rcx is 0
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
