; Exercise 02: if else (Win32 port)
;
; RAX=5. If RAX < 10, exit 20; else exit 30.
;
; Build: ml64 /c /Fo02-if-else.obj 02-if-else.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-if-else.exe 02-if-else.obj kernel32.lib
; Run: 02-if-else.exe & echo %ERRORLEVEL%
;
; Expected exit: 20
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_if_else:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_02_if_else (student routine; defined in solutions/).
    call    ex_02_if_else
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
