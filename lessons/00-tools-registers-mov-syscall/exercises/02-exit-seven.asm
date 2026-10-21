; Exercise 02: exit seven (Win32 port)
;
; Exit with status 7.
;
; Build: ml64 /c /Fo02-exit-seven.obj 02-exit-seven.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-exit-seven.exe 02-exit-seven.obj kernel32.lib
; Run: 02-exit-seven.exe & echo %ERRORLEVEL%
;
; Expected exit: 7
; Expected stdout: (none)

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32                ; Shadow space required by ABI
    
    ; TODO: Set up exit code 7 in RCX and call ExitProcess
    mov ecx, 0
    call ExitProcess

main ENDP

END
