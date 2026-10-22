; Exercise 01: cmp je (Win32 port)
;
; RAX=10, RBX=10. CMP and JE. If equal, exit 1; else exit 0.
;
; Build: ml64 /c /Fo01-cmp-je.obj 01-cmp-je.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-cmp-je.exe 01-cmp-je.obj kernel32.lib
; Run: 01-cmp-je.exe & echo %ERRORLEVEL%
;
; Expected exit: 1
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_01_cmp_je:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_01_cmp_je (student routine; defined in solutions/).
    call    ex_01_cmp_je
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
