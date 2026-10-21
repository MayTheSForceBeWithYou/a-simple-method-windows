; Exercise 11: assign macro
;
; Use = (MASM assignment) with REPT loop; exit 4 after 4 incs.
;
; Build: ml64 /c 11-assign-macro.asm && link /OUT:11-assign-macro.exe /ENTRY:main /SUBSYSTEM:CONSOLE 11-assign-macro.obj kernel32.lib
;
; Expected exit: 4

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    
    xor rcx, rcx
    ; MASM uses = for reassignable values
    i = 0
    REPT 4
        inc rcx
        i = i + 1
    ENDM
    
    call ExitProcess
main ENDP
END
