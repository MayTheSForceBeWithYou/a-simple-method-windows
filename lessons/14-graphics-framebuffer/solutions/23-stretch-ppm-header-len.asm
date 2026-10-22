; Exercise: 23-stretch-ppm-header-len
;
; STRETCH: "P6\n" length 3; exit 3.
; Expected stdout: (none)
; Expected exit: 3
;
.data
h BYTE "P6",10

.code
ex_23_stretch_ppm_header_len PROC
    sub rsp, 40
    mov rcx, 3
    mov     eax, 3
    add     rsp, 40
    ret
ex_23_stretch_ppm_header_len ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_ppm_header_len
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
