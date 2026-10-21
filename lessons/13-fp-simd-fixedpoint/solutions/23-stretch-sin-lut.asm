; Exercise 23: stretch sin lut
;
; STRETCH: LUT[0]=0 LUT[1]=1; index 1 exit 1.
; Expected exit: 1

EXTERN ExitProcess:PROC

.data
lut QWORD 0,1,0

.code
main PROC
    sub rsp, 40
    mov rcx, QWORD PTR [lut+8]
    call ExitProcess
main ENDP
END
