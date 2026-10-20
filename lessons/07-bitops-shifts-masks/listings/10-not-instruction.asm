; 10-not-instruction.asm
;
; Purpose: Demonstrate NOT instruction (bitwise inversion)
; Expected exit code: 240
; Expected stdout: (none)
;
; NOT inverts all bits: 0→1, 1→0
; Unlike other logical ops, NOT does NOT update flags

.CODE

EXTRN ExitProcess:PROC

main PROC
    mov     al, 0Fh         ; al = 00001111 binary
    not     al              ; al = 11110000 binary = 0xF0 = 240
    
    movzx   ecx, al         ; Zero-extend to 32-bit for ExitProcess
    call    ExitProcess     ; Exit with 240
main ENDP

END
