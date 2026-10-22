; Exercise 26: abs via neg
;
; rax=-42. Absolute value via neg. Exit 42.
;
; Build: ml64 /c 26-abs-via-neg.asm && link /OUT:26-abs-via-neg.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-abs-via-neg.obj kernel32.lib
;
; Expected exit: 42


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_abs_via_neg:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_26_abs_via_neg in this file.
    call    ex_26_abs_via_neg
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
