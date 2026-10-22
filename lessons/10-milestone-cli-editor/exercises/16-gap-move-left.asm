; Exercise: 16-gap-move-left
;
; Exercise 16: gap move left
; Move gap left: gap_s=3 gap_e=5 -> move left once gap_s=2 gap_e=4; exit gap_s.
;
; Contract: implement `ex_16_gap_move_left` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

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
    ; TODO: write ex_16_gap_move_left in this file.
    call    ex_16_gap_move_left
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
