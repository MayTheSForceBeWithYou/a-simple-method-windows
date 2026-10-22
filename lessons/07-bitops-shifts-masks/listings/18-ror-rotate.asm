; 18-ror-rotate.asm
;
; Purpose: Demonstrate ROR (rotate right); opposite of listing 12-rol-rotate.
; Expected exit: 128
; Expected stdout: (none)
;
; AL = 00000001; ROR by 1 wraps bit 0 into bit 7 -> 10000000 (128).

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    mov     al, 1
    ror     al, 1
    movzx   ecx, al
    call    ExitProcess
main ENDP

END
