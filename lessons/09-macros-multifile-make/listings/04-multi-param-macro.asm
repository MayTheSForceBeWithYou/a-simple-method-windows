; 04-multi-param-macro.asm
;
; Purpose: Demonstrate macro with multiple parameters
; Expected exit code: 42
; Expected stdout: (none)
;
; MASM macros can have multiple named parameters.

.CODE

EXTRN ExitProcess:PROC

; Macro to add three values
Add3 MACRO reg, val1, val2, val3
    mov     reg, val1
    add     reg, val2
    add     reg, val3
ENDM

main PROC
    Add3 rax, 10, 20, 12    ; RAX = 10 + 20 + 12 = 42
    
    mov     ecx, eax
    call    ExitProcess     ; Exit with 42
main ENDP

END
