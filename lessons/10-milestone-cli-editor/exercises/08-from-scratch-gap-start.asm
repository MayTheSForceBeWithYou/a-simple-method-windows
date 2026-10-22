; Exercise: 08-from-scratch-gap-start
;
; FROM SCRATCH: gap buffer indices gap_start=0 gap_end=8 capacity 8 empty; exit gap_end-gap_start (=8 free).
;
; Contract: implement `ex_08_from_scratch_gap_start` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_gap_start:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_gap_start in this file.
    call    ex_08_from_scratch_gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
