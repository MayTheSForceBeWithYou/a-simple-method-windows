; Exercise: 17-bounded-strcpy
;
; Exercise 17: bounded strcpy
; Copy at most 3 chars + NUL from "abcdef" into 4-byte dst; strlen dst=3.
; Expected stdout: (none)
;
; Contract: implement `ex_17_bounded_strcpy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; Exercise 17: 17-bounded-strcpy (Win32 port)
; Copy at most 3 chars + NUL from "abcdef" into 4-byte dst; strlen dst=3.
; Build: ml64 /c /Fo17-bounded-strcpy.obj 17-bounded-strcpy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:17-bounded-strcpy.exe 17-bounded-strcpy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_bounded_strcpy:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_17_bounded_strcpy in this file.
    call    ex_17_bounded_strcpy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
