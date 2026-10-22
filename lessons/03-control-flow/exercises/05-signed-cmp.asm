; Exercise 05: signed cmp (Win32 port)
;
; RAX=-5, RBX=3. Signed comparison: if RAX < RBX, exit 1; else exit 0.
;
; Build: ml64 /c /Fo05-signed-cmp.obj 05-signed-cmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:05-signed-cmp.exe 05-signed-cmp.obj kernel32.lib
; Run: 05-signed-cmp.exe & echo %ERRORLEVEL%
;
; Expected exit: 1
; Expected stdout: (none)
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_signed_cmp:PROC

main PROC
    sub     rsp, 32
    ; TODO: implement ex_05_signed_cmp (student routine; defined in solutions/).
    call    ex_05_signed_cmp
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
