; Exercise: 01-strlen
;
; Exercise 01: strlen
; strlen('hello')=5.
;
; Contract: implement `ex_01_strlen` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;

; Exercise 01: 01-strlen (Win32 port)
; Implement strlen; 'hello' -> 5.
; Build: ml64 /c /Fo01-strlen.obj 01-strlen.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:01-strlen.exe 01-strlen.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_strlen:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_01_strlen in this file.
    call    ex_01_strlen
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
