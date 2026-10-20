; Exercise 03: bss store (Win32 port) - SOLUTION
;
; Declare 1 byte in .DATA? (uninitialized). Store 7 into it, load into RCX, exit.
;
; Build: ml64 /c /Fo03-bss-store.obj 03-bss-store.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-bss-store.exe 03-bss-store.obj kernel32.lib
; Run: 03-bss-store.exe & echo %ERRORLEVEL%
;
; Expected: exit code 7

.DATA?
storage DB ?

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 32
    
    mov BYTE PTR storage, 7    ; Store 7
    movzx rcx, BYTE PTR storage ; Load back into RCX
    call ExitProcess
    
main ENDP

END
