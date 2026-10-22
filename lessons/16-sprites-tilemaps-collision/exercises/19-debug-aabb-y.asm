; Exercise 19: debug aabb y
; BUG: used x test for y. Fix overlap on y; exit 1 for overlap.
; Expected exit: 1

.CODE
EXTRN ExitProcess:PROC
EXTRN ex_19_debug_aabb_y:PROC

aabb_y_bug PROC
    ; BUG: always reports no overlap (tests wrong axis)
    xor eax, eax
    ret
aabb_y_bug ENDP

main PROC
    sub     rsp, 40
    ; TODO: write ex_19_debug_aabb_y in this file.
    call    ex_19_debug_aabb_y
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
