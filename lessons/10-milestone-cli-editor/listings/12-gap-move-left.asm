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
    sub rsp, 40
    mov     BYTE PTR buf[2], 'Q'
    mov     gap_start, 3
    mov     gap_end, 5
    mov     rax, gap_start
    dec     rax
    mov     r8, rax                 ; index 2 (do not clobber with AL load)
    movzx   edx, BYTE PTR buf[r8]
    mov     rcx, gap_end
    dec     rcx
    mov     BYTE PTR buf[rcx], dl
    mov     gap_start, r8
    mov     gap_end, rcx
    mov     ecx, 2                  ; gap_start after move
    call    ExitProcess
main ENDP

END
