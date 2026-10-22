; Exercise 23: sib full
;
; base=addr of table, index=2, scale=8, disp=0. table QWORD 0,0,42,0. Load into rcx.
;
; Build: ml64 /c 23-sib-full.asm && link /OUT:23-sib-full.exe /ENTRY:main /SUBSYSTEM:CONSOLE 23-sib-full.obj kernel32.lib
;
; Expected exit: 42


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_23_sib_full:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_23_sib_full in this file.
    call    ex_23_sib_full
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
