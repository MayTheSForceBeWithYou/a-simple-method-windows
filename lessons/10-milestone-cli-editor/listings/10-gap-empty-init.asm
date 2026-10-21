; Listing 10: Empty gap buffer (LESSON.md block 10)
;
; Purpose: Initialize empty gap; free space = gap_end - gap_start.
; Expected exit code: 0 (4096 bytes free; harness uses low 8 bits)
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     gap_start, 0
    mov     gap_end, 4096
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
