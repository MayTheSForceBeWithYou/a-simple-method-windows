; Exercise 08: div remainder (Win32 port) - SOLUTION
;
; RAX=100, divisor=7. XOR RDX and DIV. Exit with remainder (2).
;
; Build: ml64 /c /Fo08-div-remainder.obj 08-div-remainder.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-div-remainder.exe 08-div-remainder.obj kernel32.lib
; Run: 08-div-remainder.exe & echo %ERRORLEVEL%
;
; Expected: exit code 2

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, 100
    mov rbx, 7
    xor rdx, rdx               ; Clear high half
    div rbx                    ; RAX = quotient (14), RDX = remainder (2)
    mov rcx, rdx               ; Exit with remainder
    call ExitProcess
    
main ENDP

END
