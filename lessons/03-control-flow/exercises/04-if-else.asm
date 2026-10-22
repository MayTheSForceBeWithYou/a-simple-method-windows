; Exercise 04: if else
;
; If rax>10 exit 1 else exit 2. Set rax=11.
;
; Build: ml64 /c 04-if-else.asm && link /OUT:04-if-else.exe /ENTRY:main /SUBSYSTEM:CONSOLE 04-if-else.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_04_if_else:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_04_if_else in this file.
    call    ex_04_if_else
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
