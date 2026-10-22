; Exercise 16: debug off by one
;
; BUG: loop runs 0..n inclusive summing 1..5 as 0..5. Fix to sum 1..5 = 15.
;
; Build: ml64 /c 16-debug-off-by-one.asm && link /OUT:16-debug-off-by-one.exe /ENTRY:main /SUBSYSTEM:CONSOLE 16-debug-off-by-one.obj kernel32.lib
;
; Expected exit: 15


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_16_debug_off_by_one:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    xor rdi, rdi    ; BUG: fix in ex_16_debug_off_by_one
    mov rcx, 0    ; BUG: fix in ex_16_debug_off_by_one
    .loop:    ; BUG: fix in ex_16_debug_off_by_one
    cmp rcx, 5    ; BUG: fix in ex_16_debug_off_by_one
    jg .done    ; BUG: fix in ex_16_debug_off_by_one
    add rdi, rcx    ; BUG: fix in ex_16_debug_off_by_one
    inc rcx    ; BUG: fix in ex_16_debug_off_by_one
    jmp .loop    ; BUG: fix in ex_16_debug_off_by_one
    .done:    ; BUG: fix in ex_16_debug_off_by_one
    mov rax, 60    ; BUG: fix in ex_16_debug_off_by_one
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_16_debug_off_by_one in this file.
    call    ex_16_debug_off_by_one
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
