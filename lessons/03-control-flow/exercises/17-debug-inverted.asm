; Exercise 17: debug inverted
;
; BUG: jl used where jg needed. rax=5 should take 'big' path exit 2.
;
; Build: ml64 /c 17-debug-inverted.asm && link /OUT:17-debug-inverted.exe /ENTRY:main /SUBSYSTEM:CONSOLE 17-debug-inverted.obj kernel32.lib
;
; Expected exit: 2


.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_debug_inverted:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 5    ; BUG: fix in ex_17_debug_inverted
    cmp rax, 3    ; BUG: fix in ex_17_debug_inverted
    jl .big    ; BUG: fix in ex_17_debug_inverted
    mov rcx, 1    ; BUG: fix in ex_17_debug_inverted
    jmp .out    ; BUG: fix in ex_17_debug_inverted
    .big:    ; BUG: fix in ex_17_debug_inverted
    mov rcx, 2    ; BUG: fix in ex_17_debug_inverted
    .out:    ; BUG: fix in ex_17_debug_inverted
    mov rax, 60    ; BUG: fix in ex_17_debug_inverted
    ; syscall removed — use ExitProcess in student routine
__ex_call:
    ; TODO: write ex_17_debug_inverted in this file.
    call    ex_17_debug_inverted
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
