; Exercise 23: stretch sin lut
;
; STRETCH: LUT[0]=0 LUT[1]=1; index 1 exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
lut QWORD 0,1,0

.code
ex_23_stretch_sin_lut PROC
    sub rsp, 40
        mov     eax, QWORD PTR [lut+8]
    ret
    add     rsp, 40
ex_23_stretch_sin_lut ENDP
main PROC
    call    ex_23_stretch_sin_lut
    mov     rcx, rax
    call    ExitProcess
main ENDP
END
