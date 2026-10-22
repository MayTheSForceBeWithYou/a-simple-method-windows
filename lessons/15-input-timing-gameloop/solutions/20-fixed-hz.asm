; Exercise 20: fixed hz
;
; 60 Hz -> step ns approx store 16666667&0FFh; exit low byte or exit 60 as hz.
;
; Build: ml64 /c 20-fixed-hz.asm && link /OUT:20-fixed-hz.exe /ENTRY:main /SUBSYSTEM:CONSOLE 20-fixed-hz.obj kernel32.lib
;
; Expected exit: 60
; Expected stdout: (none)

EXTERN ExitProcess:PROC

.code
ex_20_fixed_hz PROC
    sub rsp, 40
    mov rcx, 60
    mov     eax, 60
    add     rsp, 40
    ret
ex_20_fixed_hz ENDP
main PROC
    sub     rsp, 40
    call    ex_20_fixed_hz
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
