; Listing 09: Gap buffer layout (LESSON.md block 9)
;
; Purpose: Declare gap buffer with gap_start and gap_end pointers.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
buf BYTE 4096 DUP(?)
gap_start QWORD ?
gap_end QWORD ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    sub     rsp, 32
    mov     gap_start, 0
    mov     gap_end, 4096
    xor     ecx, ecx
    call    ExitProcess
main ENDP

END
