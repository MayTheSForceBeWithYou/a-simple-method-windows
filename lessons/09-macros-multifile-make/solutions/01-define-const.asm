; Exercise 01: define const
;
; Define constant EXIT; exit 0.
;
; Build: ml64 /c 01-define-const.asm && link /OUT:01-define-const.exe /ENTRY:main /SUBSYSTEM:CONSOLE 01-define-const.obj kernel32.lib
;
; Expected exit: 0

EXTERN ExitProcess:PROC

; Define constant (MASM uses EQU or = for numeric constants)
SYS_EXIT EQU 0

.code
main PROC
    sub rsp, 32
    mov rcx, SYS_EXIT
    call ExitProcess
main ENDP
END
