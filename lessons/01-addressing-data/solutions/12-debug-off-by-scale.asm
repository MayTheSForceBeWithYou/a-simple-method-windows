; Exercise 12: debug off by scale
;
; BUG: array of qwords indexed with *1 instead of *8. Fix; load index 1 value 20, exit.
;
; Build: ml64 /c 12-debug-off-by-scale.asm && link /OUT:12-debug-off-by-scale.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-debug-off-by-scale.obj kernel32.lib
;
; Expected exit: 20

EXTERN ExitProcess:PROC

.data
arr QWORD 10, 20, 30

.code
ex_12_debug_off_by_scale PROC
    sub rsp, 40
    mov r8, 1
    lea r11, [arr]
    mov rcx, QWORD PTR [r11+r8*8]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_debug_off_by_scale ENDP
main PROC
    sub     rsp, 40
    call    ex_12_debug_off_by_scale
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
