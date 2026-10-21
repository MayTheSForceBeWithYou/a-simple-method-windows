; Listing 13: Move gap right one byte (LESSON.md block 13)
;
; Purpose: Copy byte at gap_end into gap_start and advance gap.
; Expected exit code: 3
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     BYTE PTR buf[5], 'Z'
    mov     gap_start, 2
    mov     gap_end, 5
    mov     rax, gap_end
    mov     al, BYTE PTR buf[rax]
    mov     rcx, gap_start
    mov     BYTE PTR buf[rcx], al
    inc     gap_start
    inc     gap_end
    mov     rax, gap_end
    sub     rax, gap_start
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
