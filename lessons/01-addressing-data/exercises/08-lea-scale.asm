; Exercise 08: lea scale (Win32 port)
;
; Use LEA to multiply: RAX=7, compute RAX*4 with LEA RAX,[RAX*4]. Exit with 28.
;
; Build: ml64 /c /Fo08-lea-scale.obj 08-lea-scale.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:08-lea-scale.exe 08-lea-scale.obj kernel32.lib
; Run: 08-lea-scale.exe & echo %ERRORLEVEL%
;
; Expected exit: 28
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_lea_scale:PROC

main PROC
    sub     rsp, 32
    ; TODO: write ex_08_lea_scale in this file.
    call    ex_08_lea_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
