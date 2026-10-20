; Exercise 06: displacement (Win32 port) - SOLUTION
;
; Array of 3 DQs: [5, 15, 25]. Load base into RBX, access element at offset 8 with [RBX+8].
;
; Build: ml64 /c /Fo06-displacement.obj 06-displacement.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-displacement.exe 06-displacement.obj kernel32.lib
; Run: 06-displacement.exe & echo %ERRORLEVEL%
;
; Expected: exit code 15

.DATA
arr DQ 5, 15, 25

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    lea rbx, arr               ; Base address
    mov rax, [rbx+8]           ; Second element (offset 8)
    mov rcx, rax
    call ExitProcess
    
main ENDP

END
