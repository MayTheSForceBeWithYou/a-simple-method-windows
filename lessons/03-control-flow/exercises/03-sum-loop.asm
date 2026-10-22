; Exercise 03: sum loop (Win32 port)
;
; Sum numbers 1 to 10 with a while loop. Exit with sum (55).
;
; Build: ml64 /c /Fo03-sum-loop.obj 03-sum-loop.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-sum-loop.exe 03-sum-loop.obj kernel32.lib
; Run: 03-sum-loop.exe & echo %ERRORLEVEL%
;
; Expected exit: 55
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_sum_loop:PROC

main PROC
    sub     rsp, 32
    ; TODO: write ex_03_sum_loop in this file.
    call    ex_03_sum_loop
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
