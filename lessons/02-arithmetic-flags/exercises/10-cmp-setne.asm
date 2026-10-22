; Exercise 10: cmp setne (Win32 port)
;
; RAX=10, RBX=20. CMP and SETNE. Exit with 1 (not equal).
;
; Build: ml64 /c /Fo10-cmp-setne.obj 10-cmp-setne.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-cmp-setne.exe 10-cmp-setne.obj kernel32.lib
; Run: 10-cmp-setne.exe & echo %ERRORLEVEL%
;
; Expected exit: 1
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_cmp_setne:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_10_cmp_setne (student routine; defined in solutions/).
    call    ex_10_cmp_setne
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
