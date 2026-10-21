; Listing 11: Insert at gap_start (LESSON.md block 11)
;
; Purpose: Store at gap_start and advance; exit remaining free bytes.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     gap_start, 2
    mov     gap_end, 6
    mov     rax, gap_start
    mov     BYTE PTR buf[rax], 'X'
    inc     gap_start
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
