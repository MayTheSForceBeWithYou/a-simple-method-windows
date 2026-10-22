; Exercise 12: debug off by scale
;
; BUG: array of qwords indexed with *1 instead of *8. Fix; load index 1 value 20, exit.
;
; Build: ml64 /c 12-debug-off-by-scale.asm && link /OUT:12-debug-off-by-scale.exe /ENTRY:main /SUBSYSTEM:CONSOLE 12-debug-off-by-scale.obj kernel32.lib
;
; Expected exit: 20


.DATA
arr QWORD 10, 20, 30

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_12_debug_off_by_scale:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rcx, 1    ; BUG: fix in ex_12_debug_off_by_scale
    mov rcx, QWORD PTR [arr+rcx*1]    ; BUG: fix in ex_12_debug_off_by_scale
    mov rax, 60    ; BUG: fix in ex_12_debug_off_by_scale
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_12_debug_off_by_scale in this file.
    call    ex_12_debug_off_by_scale
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
