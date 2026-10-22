; Exercise 21: loop mul table
;
; Compute 7*8 via repeated addition loop. Exit 56.
;
; Build: ml64 /c 21-loop-mul-table.asm && link /OUT:21-loop-mul-table.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-loop-mul-table.obj kernel32.lib
;
; Expected exit: 56


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_21_loop_mul_table:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_loop_mul_table in this file.
    call    ex_21_loop_mul_table
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
