; Exercise: 03-aabb-reject
;
; No overlap -> 0.
; Expected stdout: (none)
; Expected exit: 0
;
.code
ex_03_aabb_reject PROC
    sub rsp, 40
    xor rcx, rcx
    mov     eax, ecx
    add     rsp, 40
    ret
ex_03_aabb_reject ENDP
main PROC
    sub     rsp, 40
    call    ex_03_aabb_reject
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
