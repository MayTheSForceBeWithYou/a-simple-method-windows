; Exercise: 02-exit-seven
;
; Exercise 02: exit seven
; Exit with status 7.
;
; Contract: implement `ex_02_exit_seven` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

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
EXTRN ex_02_exit_seven:PROC

main PROC
    sub     rsp, 40                ; Shadow space required by ABI
    
    ; TODO: Set up exit code 7 in RCX and call ExitProcess
    ; TODO: write ex_02_exit_seven in this file.
    call    ex_02_exit_seven
    mov     ecx, eax
    call    ExitProcess

main ENDP

END
