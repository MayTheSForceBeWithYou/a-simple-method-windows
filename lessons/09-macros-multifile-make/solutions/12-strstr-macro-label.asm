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
main PROC
    sub rsp, 32
    
    xor rcx, rcx
    TWICE
    
    call ExitProcess
main ENDP
END
