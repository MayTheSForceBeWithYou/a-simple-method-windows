; 05-multifile-helper.asm
;
; Purpose: Helper file for multi-file project demo
;
; Exports add_two_numbers function.
; This file is linked with 05-multifile-main.asm.

.CODE

; Export (PUBLIC in MASM, equivalent to NASM global)
PUBLIC add_two_numbers

add_two_numbers PROC
    ; MS x64 calling convention: RCX, RDX are first two args
    mov     rax, rcx
    add     rax, rdx
    ret
add_two_numbers ENDP

END
