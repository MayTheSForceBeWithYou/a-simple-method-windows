; Exercise: 10-strncmp
;
; Exercise 10: strncmp
; strncmp first 2 of "abx","abz" -> 0 (equal for n=2).
;
; Contract: implement `ex_10_strncmp` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; Exercise 10: 10-strncmp (Win32 port)
; strncmp first 2 of "axy","abz" equal -> 0.
; Build: ml64 /c /Fo10-strncmp.obj 10-strncmp.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:10-strncmp.exe 10-strncmp.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_strncmp:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_10_strncmp in this file.
    call    ex_10_strncmp
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
