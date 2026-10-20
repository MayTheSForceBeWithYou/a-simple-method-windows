; Exercise 02: exit seven (Win32 port) - SOLUTION
;
; Exit with status 7.
;
; Build: ml64 /c /Fo02-exit-seven.obj 02-exit-seven.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-exit-seven.exe 02-exit-seven.obj kernel32.lib
; Run: 02-exit-seven.exe & echo %ERRORLEVEL%
;
; Expected: exit code 7

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32                ; Shadow space required by ABI
    
    mov ecx, 7                 ; Exit status in RCX (first argument)
    call ExitProcess
    
main ENDP

END
