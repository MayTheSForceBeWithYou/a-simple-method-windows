; Exercise 07: repeat macro
;
; REPT 3 increment; exit 3.
;
; Build: ml64 /c 07-repeat-macro.asm && link /OUT:07-repeat-macro.exe /ENTRY:main /SUBSYSTEM:CONSOLE 07-repeat-macro.obj kernel32.lib
;
; Expected exit: 3

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 32
    
    xor rcx, rcx
    ; MASM uses REPT instead of %rep
    REPT 3
        inc rcx
    ENDM
    
    call ExitProcess
main ENDP
END
