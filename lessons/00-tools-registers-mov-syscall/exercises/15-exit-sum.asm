; Exercise: 15-exit-sum
;
; Exercise 15: exit sum
; Set r8=10, r9=20, r10=12. Sum into rcx; exit (42).
;
; Contract: implement `ex_15_exit_sum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

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
    sub     rsp, 40
    ; TODO: write ex_15_exit_sum in this file.
    call    ex_15_exit_sum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
