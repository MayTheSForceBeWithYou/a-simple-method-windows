; Exercise 13: ifdef debug
;
; Define DEBUG; IFDEF DEBUG mov rcx,1 ELSE 0; exit 1.
;
; Build: ml64 /c 13-ifdef-debug.asm && link /OUT:13-ifdef-debug.exe /ENTRY:main /SUBSYSTEM:CONSOLE 13-ifdef-debug.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

; Define DEBUG symbol
DEBUG EQU 1

.code
ex_13_ifdef_debug PROC
    sub rsp, 40
    
    ; MASM conditional assembly
    IFDEF DEBUG
        mov rcx, 1
    ELSE
        mov rcx, 0
    ENDIF
    mov     eax, 1
    add     rsp, 40
    ret
ex_13_ifdef_debug ENDP
main PROC
    sub     rsp, 40
    call    ex_13_ifdef_debug
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
