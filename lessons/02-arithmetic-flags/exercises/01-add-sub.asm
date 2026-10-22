; Exercise 01: add sub (Win32 port)
;
; RAX=100; add 20; sub 78; exit (42).
;
; Build: ml64 /c /Fo01-add-sub.obj 01-add-sub.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-add-sub.exe 01-add-sub.obj kernel32.lib
; Run: 01-add-sub.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_add_sub:PROC

main PROC
    sub     rsp, 32
    ; TODO: write ex_01_add_sub in this file.
    call    ex_01_add_sub
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
