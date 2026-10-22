; Exercise: 15-camera-cull
;
; Sprite x=100 cam=50 view_w=40 -> culled; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.code
ex_15_camera_cull PROC
    sub rsp, 40
    mov rax, 100
    sub rax, 50
    cmp rax, 40
    jl visible
    mov rcx, 1
    jmp exit_proc
visible:
    xor rcx, rcx
exit_proc:
    mov     eax, ecx
    add     rsp, 40
    ret
ex_15_camera_cull ENDP
main PROC
    sub     rsp, 40
    call    ex_15_camera_cull
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
