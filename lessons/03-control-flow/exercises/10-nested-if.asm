; Exercise 10: nested if
;
; rax=7. If rax>0 and rax<10 exit 1 else 0.
;
; Build: ml64 /c 10-nested-if.asm && link /OUT:10-nested-if.exe /ENTRY:main /SUBSYSTEM:CONSOLE 10-nested-if.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_10_nested_if:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_10_nested_if in this file.
    call    ex_10_nested_if
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
