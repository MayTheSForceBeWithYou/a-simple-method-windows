; Exercise 15: debug inc cf
;
; Educational: compute 0FFh as byte in al, add 1 to al (wraps). Exit with CF materialized: after add, setc al; movzx rcx,al expect 1.
;
; Build: ml64 /c 15-debug-inc-cf.asm && link /OUT:15-debug-inc-cf.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-debug-inc-cf.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
ex_15_debug_inc_cf PROC
    sub rsp, 40
    mov al, 0FFh
    add al, 1
    setc al
    movzx rcx, al
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_debug_inc_cf ENDP
main PROC
    sub     rsp, 40
    call    ex_15_debug_inc_cf
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
