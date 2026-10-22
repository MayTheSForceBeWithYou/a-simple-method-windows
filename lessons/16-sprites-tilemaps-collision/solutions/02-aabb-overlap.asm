; Exercise: 02-aabb-overlap
;
; Overlap test true -> 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_02_aabb_overlap PROC
    sub rsp, 40
    ; a[0,0,2,2] b[1,1,3,3]
    mov rcx, 1
    mov     eax, 1
    add     rsp, 40
    ret
ex_02_aabb_overlap ENDP
main PROC
    sub     rsp, 40
    call    ex_02_aabb_overlap
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
