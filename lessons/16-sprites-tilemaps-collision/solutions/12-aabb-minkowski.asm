; Exercise: 12-aabb-minkowski
;
; Minkowski expand by 1; width 4->6; exit 6.
; Expected stdout: (none)
; Expected exit: 6
;
.code
ex_12_aabb_minkowski PROC
    sub rsp, 40
    mov rcx, 4
    add rcx, 2
    mov     eax, ecx
    add     rsp, 40
    ret
ex_12_aabb_minkowski ENDP
main PROC
    sub     rsp, 40
    call    ex_12_aabb_minkowski
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
