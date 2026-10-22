; Exercise 06: sum 1 n
;
; Sum 1..n for n=10 into rcx (55).
;
; Build: ml64 /c 06-sum-1-n.asm && link /OUT:06-sum-1-n.exe /ENTRY:main /SUBSYSTEM:CONSOLE 06-sum-1-n.obj kernel32.lib
;
; Expected exit: 55


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_sum_1_n:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_06_sum_1_n in this file.
    call    ex_06_sum_1_n
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
