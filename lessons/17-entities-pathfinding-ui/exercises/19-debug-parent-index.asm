; Exercise: 19-debug-parent-index
;
; Exercise 19: debug parent index
; BUG: parent[i] wrong. Fix reconstruct step count exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_19_debug_parent_index` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; Exercise 19: debug parent index
; BUG: parent table uses wrong index when reconstructing path. Expect 2 steps.
; Expected exit: 2

.DATA
parent DWORD 0, 0, 1, 2
goal DWORD 3

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_parent_index:PROC

reconstruct_steps_bug PROC
    mov ecx, DWORD PTR goal
    xor eax, eax
step_loop:
    cmp ecx, 0
    je steps_done
    inc eax
    lea rdx, parent
    mov ecx, DWORD PTR [rdx + rcx*4]
    jmp step_loop
steps_done:
    dec eax                         ; BUG: off-by-one on step count
    ret
reconstruct_steps_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_parent_index in this file.
    call    ex_19_debug_parent_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
