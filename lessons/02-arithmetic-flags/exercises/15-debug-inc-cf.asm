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

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    ; BUG: see exercise description; fix in student routine.
    ; TODO: write ex_15_debug_inc_cf in this file.
    call    ex_15_debug_inc_cf
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
