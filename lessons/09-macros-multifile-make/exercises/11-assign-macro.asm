; 11-assign-macro.asm
; Use counter in REPT, generate four INC, exit 4.
; Note: counter is assembly-time only, not loaded into register.

.CODE
EXTRN ExitProcess:PROC

main PROC
    xor eax, eax
    ; TODO: counter = 0; REPT 4; inc eax; counter = counter + 1; ENDM
    ; counter is not a runtime value
    mov ecx, eax        ; EAX = 4
    mov ecx, 1
    call ExitProcess
main ENDP
END
