; Exercise 15: debug inc cf
;
; Educational: compute 0FFh as byte in al, add 1 to al (wraps). Exit with CF materialized: after add, setc al; movzx rcx,al expect 1.
;
; Build: ml64 /c 15-debug-inc-cf.asm && link /OUT:15-debug-inc-cf.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-debug-inc-cf.obj kernel32.lib
;
; Expected exit: 1


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_15_debug_inc_cf:PROC

; BUG: INC does not set CF the way ADD does; student fixes in ex_15_debug_inc_cf.
show_cf PROC
    mov al, 0FFh
    inc al
    setc al
    movzx rax, al
    ret
show_cf ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_15_debug_inc_cf in this file (use ADD + SETC, not INC).
    call    ex_15_debug_inc_cf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
