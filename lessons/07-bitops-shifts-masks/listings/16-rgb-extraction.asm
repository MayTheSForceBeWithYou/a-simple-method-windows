; 16-rgb-extraction.asm
;
; Purpose: Extract RGB components from a 24-bit color value
; Expected exit code: 239
; Expected stdout: (none)
;
; A 24-bit RGB color packs three 8-bit components:
;   Red:   bits 16-23
;   Green: bits 8-15
;   Blue:  bits 0-7
;
; Extracts each component from 0xABCDEF and exits with blue component.

.CODE

EXTRN ExitProcess:PROC

main PROC FRAME
    push    rbx
    .pushreg rbx
    push    r12
    .pushreg r12
    push    r13
    .pushreg r13
    .endprolog
    
    mov     rax, 0ABCDEFh   ; color = 0xABCDEF
    
    ; Extract red (bits 16-23)
    mov     rbx, rax
    shr     rbx, 16         ; Shift bits 16-23 down to bits 0-7
    and     rbx, 0FFh       ; Mask to 8 bits
    ; rbx = 0xAB = 171
    
    ; Extract green (bits 8-15)
    mov     r12, rax
    shr     r12, 8
    and     r12, 0FFh
    ; r12 = 0xCD = 205
    
    ; Extract blue (bits 0-7)
    mov     r13, rax
    and     r13, 0FFh       ; No shift needed (already at bit 0)
    ; r13 = 0xEF = 239
    
    ; Exit with blue component
    mov     ecx, r13d
    call    ExitProcess     ; Exit with 239
main ENDP

END
