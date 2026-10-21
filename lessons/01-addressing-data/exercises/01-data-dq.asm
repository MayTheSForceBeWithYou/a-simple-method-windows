; Exercise 01: data dq (Win32 port)
;
; Define count DQ 41 in .DATA. Load into RAX, add 1, exit with result (42).
;
; Build: ml64 /c /Fo01-data-dq.obj 01-data-dq.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-data-dq.exe 01-data-dq.obj kernel32.lib
; Run: 01-data-dq.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
; TODO: Declare .DATA section with count DQ 41

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    ; TODO: Load count into RAX, add 1, move to RCX, exit
    

    ; TODO: complete exercise (scaffold uses wrong exit code)
    mov ecx, 0
    call ExitProcess
main ENDP

END
