; Exercise 24: from scratch macro abs
;
; FROM SCRATCH: MACRO ABS for register; ABS rcx with -9 -> 9 exit 9.
;
; Build: ml64 /c 24-from-scratch-macro-abs.asm && link /OUT:24-from-scratch-macro-abs.exe /ENTRY:main /SUBSYSTEM:CONSOLE 24-from-scratch-macro-abs.obj kernel32.lib
;
; Expected exit: 9

EXTERN ExitProcess:PROC

; MASM macro for absolute value with LOCAL label
ABS MACRO reg
    LOCAL ok
    cmp reg, 0
    jge ok
    neg reg
ok:
ENDM

.code
ex_24_from_scratch_macro_abs PROC
    sub rsp, 40
    
    mov rcx, -9
    ABS rcx
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_24_from_scratch_macro_abs ENDP
main PROC
    sub     rsp, 40
    call    ex_24_from_scratch_macro_abs
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
