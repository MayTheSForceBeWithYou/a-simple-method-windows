; Exercise 15: exit sum (Win32 port)
;
; Add three numbers and exit with their sum.
;
; Build: ml64 /c /Fo15-exit-sum.obj 15-exit-sum.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:15-exit-sum.exe 15-exit-sum.obj kernel32.lib
; Run: 15-exit-sum.exe & echo %ERRORLEVEL%
;
; Expected exit: 100 (10 + 30 + 60)

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_exit_sum:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_15_exit_sum (student routine; defined in solutions/).
    call    ex_15_exit_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
