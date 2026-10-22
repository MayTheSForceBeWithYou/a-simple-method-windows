; Exercise 07: repeat macro
;
; REPT 3 increment; exit 3.
;
; Build: ml64 /c 07-repeat-macro.asm && link /OUT:07-repeat-macro.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-repeat-macro.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
ex_07_repeat_macro PROC
    sub rsp, 40
    
    xor rcx, rcx
    ; MASM uses REPT instead of %rep
    REPT 3
        inc rcx
    ENDM
    mov     eax, 3
    ret
ex_07_repeat_macro ENDP
main PROC
    call    ex_07_repeat_macro
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
