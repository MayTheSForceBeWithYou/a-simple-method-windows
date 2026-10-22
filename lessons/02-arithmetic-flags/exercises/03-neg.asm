; Exercise: 03-neg
;
; Exercise 03: neg
; mov rcx, 5; neg rcx; add rcx, 10; exit (5).
;
; Contract: implement `ex_03_neg` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; Exercise 03: neg (Win32 port)
;
; RAX=-42; negate it; exit (42).
;
; Build: ml64 /c /Fo03-neg.obj 03-neg.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-neg.exe 03-neg.obj kernel32.lib
; Run: 03-neg.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_neg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_neg in this file.
    call    ex_03_neg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
