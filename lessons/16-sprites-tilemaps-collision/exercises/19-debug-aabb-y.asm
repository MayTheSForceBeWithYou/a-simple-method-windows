; Exercise: 19-debug-aabb-y
;
; BUG: used x test for y. Fix overlap on y; exit 1 for overlap.
; Expected stdout: (none)
;
; Contract: implement `ex_19_debug_aabb_y` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_19_debug_aabb_y:PROC

; a: x=0 w=10 y=0 h=2   b: x=0 w=10 y=1 h=2  -> overlap on Y
aabb_overlap_y_bug PROC
    ; BUG: compares x+w instead of y+h
    mov rax, 0                  ; a.x
    mov rcx, 10                 ; a.w
    mov rdx, 0                  ; b.x
    mov r8, 10                  ; b.w
    mov r9, rax
    add r9, rcx
    cmp rdx, r9
    jge no_y_overlap
    mov eax, 1
    ret
no_y_overlap:
    xor eax, eax
    ret
aabb_overlap_y_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_aabb_y in this file (test Y axis).
    call    ex_19_debug_aabb_y
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
