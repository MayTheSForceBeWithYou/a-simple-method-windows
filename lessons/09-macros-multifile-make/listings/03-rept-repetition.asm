; 03-rept-repetition.asm
;
; Purpose: Demonstrate REPT for compile-time repetition
; Expected exit code: 3
; Expected stdout: (none)
;
; REPT (equivalent to NASM %rep) generates code at assembly time.
; The CPU executes N separate instructions, not a runtime loop.

.CODE

EXTRN ExitProcess:PROC

main PROC
    sub rsp, 40
    xor     eax, eax
    
    ; Generate three INC instructions at assembly time
    REPT 3
    inc     eax
    ENDM
    
    ; EAX = 3
    mov     ecx, eax
    call    ExitProcess     ; Exit with 3
main ENDP

END
