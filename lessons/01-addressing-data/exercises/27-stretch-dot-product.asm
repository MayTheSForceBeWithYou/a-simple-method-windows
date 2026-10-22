; Exercise: 27-stretch-dot-product
;
; STRETCH: u QWORD 2,3,4  v QWORD 5,6,7. rcx=2*5+3*6+4*7 (56). imul allowed.
;
; Contract: implement `ex_27_stretch_dot_product` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 56
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_27_stretch_dot_product:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_stretch_dot_product in this file.
    call    ex_27_stretch_dot_product
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
