; 09-macro-pushregs.asm
; Macro pushes RBX, R12; pop in reverse order; exit 5.

.CODE
EXTRN ExitProcess:PROC

; TODO: PushRegs MACRO; push rbx; push r12; ENDM
; TODO: PopRegs MACRO; pop r12; pop rbx; ENDM

main PROC
    mov eax, 5
    ; TODO: PushRegs; PopRegs
    mov ecx, eax
    call ExitProcess
main ENDP
END
