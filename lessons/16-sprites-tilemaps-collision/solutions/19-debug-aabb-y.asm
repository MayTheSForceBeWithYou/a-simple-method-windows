; Exercise: 19-debug-aabb-y
;
; BUG: used x test for y. Fix overlap on y; exit 1 for overlap.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_19_debug_aabb_y PROC
    sub rsp, 40
    ; a.y=0 a.h=2; b.y=1 b.h=2 overlap
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_19_debug_aabb_y ENDP
main PROC
    sub     rsp, 40
    call    ex_19_debug_aabb_y
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
