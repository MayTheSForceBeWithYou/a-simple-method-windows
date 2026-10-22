; Exercise 16: bss resq
;
; QWORD ? DUP(4). Store 1,2,3,4 into consecutive qwords; sum into rcx (10); exit.
;
; Build: ml64 /c 16-bss-resq.asm && link /OUT:16-bss-resq.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-bss-resq.obj kernel32.lib
;
; Expected exit: 10


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_bss_resq:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_16_bss_resq in this file.
    call    ex_16_bss_resq
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
