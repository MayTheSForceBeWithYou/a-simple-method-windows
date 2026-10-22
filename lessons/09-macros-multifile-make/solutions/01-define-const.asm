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
ex_01_define_const PROC
    sub rsp, 40
        mov     eax, SYS_EXIT
    add     rsp, 40
    ret
ex_01_define_const ENDP
main PROC
    sub     rsp, 40
    call    ex_01_define_const
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
