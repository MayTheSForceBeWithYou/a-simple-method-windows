; Exercise 06: eax zero extends (Win32 port)
;
; Fill RAX with -1, then write 5 to EAX. Verify upper 32 bits are cleared.
; Exit with the low byte of RAX (should be 5).
;
; Build: ml64 /c /Fo06-eax-zero-extends.obj 06-eax-zero-extends.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:06-eax-zero-extends.exe 06-eax-zero-extends.obj kernel32.lib
; Run: 06-eax-zero-extends.exe & echo %ERRORLEVEL%
;
; Expected: exit code 5

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_eax_zero_extends:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_eax_zero_extends in this file.
    call    ex_06_eax_zero_extends
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
