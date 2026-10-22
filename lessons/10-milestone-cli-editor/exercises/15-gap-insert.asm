; 15-gap-insert.asm: Insert in gap buffer (store at gap_start, inc gap_start), exit gap_start
.DATA?
buf DB 256 DUP(?)
gap_start QWORD ?
gap_end QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_gap_insert:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_gap_insert in this file.
    call    ex_15_gap_insert
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
