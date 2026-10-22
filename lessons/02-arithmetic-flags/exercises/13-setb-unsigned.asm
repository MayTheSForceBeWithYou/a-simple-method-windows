; Exercise 13: setb unsigned
;
; rax=1, rbx=2. cmp; setb al; exit 1 (below unsigned).
;
; Build: ml64 /c 13-setb-unsigned.asm && link /OUT:13-setb-unsigned.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-setb-unsigned.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_13_setb_unsigned:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_13_setb_unsigned in this file.
    call    ex_13_setb_unsigned
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
