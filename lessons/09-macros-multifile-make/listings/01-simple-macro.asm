; 01-simple-macro.asm
;
; Purpose: Demonstrate simple MASM macro definition and use
; Expected exit code: 7
; Expected stdout: (none)
;
; MASM macros use MACRO ... ENDM syntax.
; Parameters are named, not numbered like NASM's %1, %2.

.CODE

EXTRN ExitProcess:PROC

; Define a macro to exit with a given status
ExitWith MACRO status
    mov     ecx, status
    call    ExitProcess
ENDM

main PROC
    ExitWith 7              ; Expands to: mov ecx, 7; call ExitProcess
main ENDP

END
