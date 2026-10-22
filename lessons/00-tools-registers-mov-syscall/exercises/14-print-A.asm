; Exercise 14: print A
;
; Write "A\n". Exit 0.
;
; Build: ml64 /c 14-print-A.asm && link /OUT:14-print-A.exe /ENTRY:main /SUBSYSTEM:CONSOLE 14-print-A.obj kernel32.lib
;
; Expected exit: 0


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_14_print_A:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_14_print_A in this file.
    call    ex_14_print_A
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
