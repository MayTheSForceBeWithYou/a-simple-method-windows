; Listing 12: Move gap left one byte (LESSON.md block 12)
;
; Purpose: Copy byte left of gap into gap from the right side.
; Expected exit code: 2
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     BYTE PTR buf[2], 'Q'
    mov     gap_start, 3
    mov     gap_end, 5
    mov     rax, gap_start
    dec     rax
    mov     al, BYTE PTR buf[rax]
    mov     rcx, gap_end
    dec     rcx
    mov     BYTE PTR buf[rcx], al
    mov     gap_start, rax
    mov     gap_end, rcx
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
