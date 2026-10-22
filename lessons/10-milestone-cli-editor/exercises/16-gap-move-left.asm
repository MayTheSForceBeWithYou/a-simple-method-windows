; 16-gap-move-left.asm: Move gap left (copy byte to gap_end-1, dec both), exit gap_start
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_gap_move_left:PROC
main PROC
    sub     rsp, 40
    ; TODO: implement ex_16_gap_move_left (student routine; defined in solutions/).
    call    ex_16_gap_move_left
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
