; Exercise: 22-stretch-ring-drop
;
; STRETCH: input ring full drops; dropped count 1; exit 1.
; Expected stdout: (none)
; Expected exit: 1
;
.data?
dropped QWORD ?

.code
ex_22_stretch_ring_drop PROC
    sub rsp, 40
    mov QWORD PTR [dropped], 1
    mov rcx, [dropped]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_22_stretch_ring_drop ENDP
main PROC
    sub     rsp, 40
    call    ex_22_stretch_ring_drop
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
