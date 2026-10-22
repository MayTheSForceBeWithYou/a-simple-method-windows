; Exercise: 16-pitch-bytes
;
; pitch=width*4 aligned up to 16: width=5 -> 20 align 32? 20; exit 20.
; Expected stdout: (none)
; Expected exit: 20
;
.code
ex_16_pitch_bytes PROC
    sub rsp, 40
    mov rcx, 5
    imul rcx, 4
    mov     eax, ecx
    add     rsp, 40
    ret
ex_16_pitch_bytes ENDP
main PROC
    sub     rsp, 40
    call    ex_16_pitch_bytes
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
