; Exercise: 23-stretch-chunk-coords
;
; STRETCH: chunk = tile>>4; tile=40 -> 2; exit 2.
; Expected stdout: (none)
; Expected exit: 2
;
.code
ex_23_stretch_chunk_coords PROC
    sub rsp, 40
    mov rax, 40
    shr rax, 4
    mov rcx, rax
    mov     eax, eax
    add     rsp, 40
    ret
ex_23_stretch_chunk_coords ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_chunk_coords
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
