; Exercise: 02-strcpy
;
; Exercise 02: strcpy
; Copy 'yo' to bss; exit length=2.
;
; Contract: implement `ex_02_strcpy` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 02: 02-strcpy (Win32 port)
; Copy 'yo' to bss; return length written 2; exit 2.
; Build: ml64 /c /Fo02-strcpy.obj 02-strcpy.asm && link /ENTRY:main /SUBSYSTEM:CONSOLE /OUT:02-strcpy.exe 02-strcpy.obj kernel32.lib

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_strcpy:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_02_strcpy in this file.
    call    ex_02_strcpy
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
