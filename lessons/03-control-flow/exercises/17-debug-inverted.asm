; Exercise: 17-debug-inverted
;
; BUG: jl used where jg needed. rax=5 should take 'big' path exit 2.
;
; Contract: implement `ex_17_debug_inverted` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_17_debug_inverted:PROC

main PROC
    sub     rsp, 40
    ; Broken starter (implement corrected logic in student routine):
    jmp     __ex_call
    mov rax, 5    ; BUG: fix in ex_17_debug_inverted
    cmp rax, 3    ; BUG: fix in ex_17_debug_inverted
    jl dbg_big    ; BUG: fix in ex_17_debug_inverted
    mov rcx, 1    ; BUG: fix in ex_17_debug_inverted
    jmp dbg_out    ; BUG: fix in ex_17_debug_inverted
dbg_big:    ; BUG: fix in ex_17_debug_inverted
    mov rcx, 2    ; BUG: fix in ex_17_debug_inverted
dbg_out:    ; BUG: fix in ex_17_debug_inverted

__ex_call:
    ; TODO: write ex_17_debug_inverted in this file.
    call    ex_17_debug_inverted
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
