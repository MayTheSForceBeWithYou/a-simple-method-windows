; 02-macro-with-local.asm
;
; Purpose: Demonstrate LOCAL directive for macro-local labels
; Expected exit code: 9
; Expected stdout: (none)
;
; LOCAL creates unique labels for each macro invocation,
; equivalent to NASM's %%label.

.CODE

EXTRN ExitProcess:PROC

; Macro to compute absolute value
AbsValue MACRO reg
    LOCAL skip_neg
    cmp     reg, 0
    jge     skip_neg
    neg     reg
skip_neg:
ENDM

main PROC
    sub rsp, 40
    mov     rax, -9
    AbsValue rax            ; First invocation uses unique skip_neg
    mov     rbx, -5
    AbsValue rbx            ; Second invocation uses different skip_neg
    
    ; Exit with absolute value of -9 (= 9)
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
