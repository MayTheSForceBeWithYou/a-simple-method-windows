; Exercise 20: macro with params
;
; MACRO ADD3 with 3 params; mov rax,a; add b; add c; ADD3 10,20,12 exit 42.
;
; Build: ml64 /c 20-macro-with-params.asm && link /OUT:20-macro-with-params.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-macro-with-params.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

; MASM macro with named parameters
ADD3 MACRO a, b, c
    mov rax, a
    add rax, b
    add rax, c
ENDM

.code
main PROC
    sub rsp, 40
    
    ADD3 10, 20, 12
    
    mov rcx, rax
    call ExitProcess
main ENDP
END
