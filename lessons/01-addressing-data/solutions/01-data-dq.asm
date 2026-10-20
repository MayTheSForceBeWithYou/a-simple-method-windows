; Exercise 01: data dq (Win32 port) - SOLUTION
;
; Define count DQ 41 in .DATA. Load into RAX, add 1, exit with result (42).
;
; Build: ml64 /c /Fo01-data-dq.obj 01-data-dq.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-data-dq.exe 01-data-dq.obj kernel32.lib
; Run: 01-data-dq.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.DATA
count DQ 41

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov rax, count             ; Load count (41)
    add rax, 1                 ; Increment to 42
    mov rcx, rax               ; Move to argument register
    call ExitProcess
    
main ENDP

END
