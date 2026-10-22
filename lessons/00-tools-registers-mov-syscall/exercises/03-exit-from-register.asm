; Exercise: 03-exit-from-register
;
; Exercise 03: exit from register
; Put 42 in rbx, copy to rcx, exit with that status. Immediate only allowed when loading rbx.
;
; Contract: implement `ex_03_exit_from_register` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 42
;

; Exercise 03: exit from register (Win32 port)
;
; Put 42 into RAX, then move it to the correct register for ExitProcess.
;
; Build: ml64 /c /Fo03-exit-from-register.obj 03-exit-from-register.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:03-exit-from-register.exe 03-exit-from-register.obj kernel32.lib
; Run: 03-exit-from-register.exe & echo %ERRORLEVEL%
;
; Expected: exit code 42

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_03_exit_from_register:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_03_exit_from_register in this file.
    call    ex_03_exit_from_register
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
