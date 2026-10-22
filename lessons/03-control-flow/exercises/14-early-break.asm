; Exercise 14: early break
;
; Sum arr QWORD 5,5,5,5 until sum>=10; exit sum (10).
;
; Build: ml64 /c 14-early-break.asm && link /OUT:14-early-break.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-early-break.obj kernel32.lib
;
; Expected exit: 10


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_early_break:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_early_break in this file.
    call    ex_14_early_break
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
