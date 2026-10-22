; Exercise 03: bss store (Win32 port)
;
; Declare 1 byte in .DATA? (uninitialized). Store 7 into it, load into RCX, exit.
;
; Build: ml64 /c /Fo03-bss-store.obj 03-bss-store.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-bss-store.exe 03-bss-store.obj kernel32.lib
; Run: 03-bss-store.exe & echo %ERRORLEVEL%
;
; Expected exit: 7
; Expected stdout: (none)
; TODO: Declare .DATA? section with a 1-byte variable

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_bss_store:PROC

main PROC
    sub     rsp, 32
    ; TODO: Store 7 to the byte variable, load it back, exit with it
    ; TODO: write ex_03_bss_store in this file.
    call    ex_03_bss_store
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
