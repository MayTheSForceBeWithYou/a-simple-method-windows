; 11-assign-macro.asm
; Use counter in REPT, generate four INC, exit 4.
; Note: counter is assembly-time only, not loaded into register.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_assign_macro:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_11_assign_macro in this file.
    call    ex_11_assign_macro
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
