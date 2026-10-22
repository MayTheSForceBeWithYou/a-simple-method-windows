; Exercise: 23-stretch-sin-lut
;
; STRETCH: LUT[0]=0 LUT[1]=1; index 1 exit 1.
; Expected exit: 1
;
.data
lut QWORD 0,1,0

.code
ex_23_stretch_sin_lut PROC
    sub rsp, 40
    mov rcx, QWORD PTR [lut+8]
    mov     eax, ecx
    add     rsp, 40
    ret
ex_23_stretch_sin_lut ENDP
main PROC
    sub     rsp, 40
    call    ex_23_stretch_sin_lut
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
