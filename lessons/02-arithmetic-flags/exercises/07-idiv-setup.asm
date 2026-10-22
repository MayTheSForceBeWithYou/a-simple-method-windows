; Exercise 07: idiv setup (Win32 port)
;
; RAX=126, divisor=3. Use CQO and IDIV. Exit with quotient (42).
;
; Build: ml64 /c /Fo07-idiv-setup.obj 07-idiv-setup.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:07-idiv-setup.exe 07-idiv-setup.obj kernel32.lib
; Run: 07-idiv-setup.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_07_idiv_setup:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_07_idiv_setup (student routine; defined in solutions/).
    call    ex_07_idiv_setup
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
