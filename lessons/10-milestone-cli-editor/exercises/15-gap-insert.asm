; Exercise: 15-gap-insert
;
; Gap buffer: gap_s=2 gap_e=6; insert shrinks gap; free space after insert one = 3; exit 3.
;
; Contract: implement `ex_15_gap_insert` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_gap_insert:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_gap_insert in this file.
    call    ex_15_gap_insert
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
