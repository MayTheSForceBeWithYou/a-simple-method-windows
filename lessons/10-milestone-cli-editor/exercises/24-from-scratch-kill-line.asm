; 24-from-scratch-kill-line.asm: Delete from cursor to newline, exit len
.DATA?
buf DB 256 DUP(?)
len QWORD ?
cur QWORD ?
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_24_from_scratch_kill_line:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_24_from_scratch_kill_line in this file.
    call    ex_24_from_scratch_kill_line
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
