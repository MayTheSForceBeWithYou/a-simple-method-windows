; Exercise 15: debug inc cf
;
; Educational: compute 0xFF as byte in al, add 1 to al (wraps). Exit with CF materialized: after add, setc al; movzx rcx,al expect 1.
;
; Build: ml64 /c 15-debug-inc-cf.asm && link /OUT:15-debug-inc-cf.exe /ENTRY:main /SUBSYSTEM:CONSOLE 15-debug-inc-cf.obj kernel32.lib
;
; Expected exit: 1

EXTERN ExitProcess:PROC

.code
main PROC
    sub rsp, 40
    mov al, 0FFh
    add al, 1
    setc al
    movzx rcx, al
    call ExitProcess
main ENDP
END
