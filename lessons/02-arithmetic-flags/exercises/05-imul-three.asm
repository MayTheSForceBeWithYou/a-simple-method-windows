; Exercise 05: imul three (Win32 port)
;
; RBX=14. IMUL RAX, RBX, 3. Exit with 42.
;
; Build: ml64 /c /Fo05-imul-three.obj 05-imul-three.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-imul-three.exe 05-imul-three.obj kernel32.lib
; Run: 05-imul-three.exe & echo %ERRORLEVEL%
;
; Expected exit: 42
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_imul_three:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_05_imul_three (student routine; defined in solutions/).
    call    ex_05_imul_three
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
