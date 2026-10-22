; Exercise 04: imul two (Win32 port)
;
; RAX=6, RBX=7. IMUL RAX, RBX. Exit with 42.
;
; Build: ml64 /c /Fo04-imul-two.obj 04-imul-two.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:04-imul-two.exe 04-imul-two.obj kernel32.lib
; Run: 04-imul-two.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_imul_two:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_04_imul_two (student routine; defined in solutions/).
    call    ex_04_imul_two
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
