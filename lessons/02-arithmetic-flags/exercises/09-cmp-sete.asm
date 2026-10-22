; Exercise 09: cmp sete (Win32 port)
;
; RAX=42, RBX=42. CMP and SETE. Exit with 1 (true).
;
; Build: ml64 /c /Fo09-cmp-sete.obj 09-cmp-sete.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-cmp-sete.exe 09-cmp-sete.obj kernel32.lib
; Run: 09-cmp-sete.exe & echo %ERRORLEVEL%
;
; Expected exit: 1
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_cmp_sete:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_cmp_sete in this file.
    call    ex_09_cmp_sete
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
