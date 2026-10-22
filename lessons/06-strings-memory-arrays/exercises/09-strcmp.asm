; Exercise: 09-strcmp
;
; Exercise 09: strcmp
; strcmp "abc","abd" -> 1.
;
; Contract: implement `ex_09_strcmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; Exercise 09: 09-strcmp (Win32 port)
; strcmp "abc","abd" -> nonzero (1). Exit 1.
; Build: ml64 /c /Fo09-strcmp.obj 09-strcmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:09-strcmp.exe 09-strcmp.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_strcmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_09_strcmp in this file.
    call    ex_09_strcmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
