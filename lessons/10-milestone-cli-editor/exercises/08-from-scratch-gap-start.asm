; 08-from-scratch-gap-start.asm: Init gap buffer (gap_start=0, gap_end=256), exit 0
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
