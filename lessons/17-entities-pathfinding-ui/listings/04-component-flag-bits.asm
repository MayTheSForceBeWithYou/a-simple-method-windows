; Listing 04: ECS component flag bits (LESSON.md block 4)
; Expected exit: 7
; Expected stdout: (none)

POS EQU 1
VEL EQU 2
HP  EQU 4

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     eax, POS OR VEL OR HP
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
