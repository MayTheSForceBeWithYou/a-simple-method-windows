; Exercise: 19-debug-map-bounds
;
; Exercise 19: debug map bounds
; BUG: no bounds check. Clamp x=99 to w-1=7; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_19_debug_map_bounds` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;

; Exercise 19: debug map bounds
; BUG: clamp uses width instead of width-1. x=99 on width 8 should clamp to 7.
; Expected exit: 7

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_map_bounds:PROC

clamp_x_bug PROC
    mov rax, 99
    mov rcx, 8                  ; map width
    cmp rax, rcx
    jl clamp_ok
    mov rax, rcx                ; BUG: should be rcx-1
clamp_ok:
    ret
clamp_x_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_map_bounds in this file.
    call    ex_19_debug_map_bounds
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
