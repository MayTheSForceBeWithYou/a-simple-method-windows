; Exercise 08: from scratch macro add
;
; FROM SCRATCH: MACRO ADD_IMM reg,imm; use to build 40+2 exit 42.
;
; Build: ml64 /c 08-from-scratch-macro-add.asm && link /OUT:08-from-scratch-macro-add.exe /ENTRY:main /SUBSYSTEM:CONSOLE 08-from-scratch-macro-add.obj kernel32.lib
;
; Expected exit: 42

EXTERN ExitProcess:PROC

; MASM macro with named parameters
ADD_IMM MACRO reg, imm
    add reg, imm
ENDM

.code
main PROC
    sub rsp, 40
    
    mov rcx, 40
    ADD_IMM rcx, 2
    
    call ExitProcess
main ENDP
END
