; 09-macro-pushregs.asm
; Macro pushes RBX, R12; pop in reverse order; exit 5.

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_macro_pushregs:PROC

; TODO: PushRegs MACRO; push rbx; push r12; ENDM
; TODO: PopRegs MACRO; pop r12; pop rbx; ENDM

main PROC
    sub     rsp, 40
    ; TODO: implement ex_09_macro_pushregs (student routine; defined in solutions/).
    call    ex_09_macro_pushregs
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
