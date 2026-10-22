; Exercise 02: inc dec (Win32 port)
;
; RAX=0; inc 5 times; dec 2 times; exit (3).
;
; Build: ml64 /c /Fo02-inc-dec.obj 02-inc-dec.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-inc-dec.exe 02-inc-dec.obj kernel32.lib
; Run: 02-inc-dec.exe & echo %ERRORLEVEL%
;
; Expected exit: 3
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_02_inc_dec:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_02_inc_dec (student routine; defined in solutions/).
    call    ex_02_inc_dec
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
