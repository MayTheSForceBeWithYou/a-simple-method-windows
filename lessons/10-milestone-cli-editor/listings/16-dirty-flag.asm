; Listing 16: Dirty flag on edit, clear on save (LESSON.md block 16)
;
; Purpose: Set dirty on edit and clear after mock save.
; Expected exit code: 0
; Expected stdout: (none)

.DATA?
dirty BYTE ?

.CODE
EXTRN ExitProcess:PROC

main PROC
    mov     BYTE PTR dirty, 1
    mov     BYTE PTR dirty, 0
    movzx   ecx, BYTE PTR dirty
    call    ExitProcess
main ENDP

END
