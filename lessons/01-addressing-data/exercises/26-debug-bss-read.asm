; Exercise 26: debug bss read
;
; BUG: reads .data? before store (0). Store 12 first; exit 12.
;
; Build: ml64 /c 26-debug-bss-read.asm && link /OUT:26-debug-bss-read.exe /ENTRY:main /SUBSYSTEM:CONSOLE 26-debug-bss-read.obj kernel32.lib
;
; Expected exit: 12


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_26_debug_bss_read:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rcx, [v]    ; BUG: fix in ex_26_debug_bss_read
    mov rax, 60    ; BUG: fix in ex_26_debug_bss_read
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_26_debug_bss_read in this file.
    call    ex_26_debug_bss_read
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
