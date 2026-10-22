; Exercise 12: macro local labels
;
; MACRO TWICE with inc instructions; exit 2.
;
; Build: ml64 /c 12-strstr-macro-label.asm && link /OUT:12-strstr-macro-label.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-strstr-macro-label.obj kernel32.lib
;
; Expected exit: 2

EXTERN ExitProcess:PROC

; MASM macro with simple instructions
TWICE MACRO
    inc rcx
    inc rcx
ENDM

.code
ex_12_strstr_macro_label PROC
    sub rsp, 40
    
    xor rcx, rcx
    TWICE
    
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_strstr_macro_label ENDP
main PROC
    sub     rsp, 40
    call    ex_12_strstr_macro_label
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
