; Exercise 21: index loop prep
;
; arr BYTE 7,8,9. Without loops yet: sum using three scaled/byte loads into rcx (24).
;
; Build: ml64 /c 21-index-loop-prep.asm && link /OUT:21-index-loop-prep.exe /ENTRY:main /SUBSYSTEM:CONSOLE 21-index-loop-prep.obj kernel32.lib
;
; Expected exit: 24


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_21_index_loop_prep:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_index_loop_prep in this file.
    call    ex_21_index_loop_prep
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
