; Exercise: 27-stretch-pow2
;
; STRETCH: compute 2^8 with successive imuls. Exit (256 - 256)=0.
;
; Contract: implement `ex_27_stretch_pow2` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_27_stretch_pow2:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_27_stretch_pow2 in this file.
    call    ex_27_stretch_pow2
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
