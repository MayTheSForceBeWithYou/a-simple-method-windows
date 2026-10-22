; Exercise 15: gap insert
;
; Gap buffer: gap_s=2 gap_e=6; insert shrinks gap; free space after insert one = 3; exit 3.
;
; Build: ml64 /c 15-gap-insert.asm && link /OUT:15-gap-insert.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-gap-insert.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.data?
gap_s QWORD ?
gap_e QWORD ?

.code

ex_15_gap_insert PROC
mov QWORD PTR [gap_s], 2
    mov QWORD PTR [gap_e], 6
    
    ; Insert one char at gap_s
    inc QWORD PTR [gap_s]
    
    ; Calculate free space
    mov rcx, [gap_e]
    sub rcx, [gap_s]
    mov     eax, ecx
    ret
ex_15_gap_insert ENDP
main PROC
    sub     rsp, 40
    call    ex_15_gap_insert
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
