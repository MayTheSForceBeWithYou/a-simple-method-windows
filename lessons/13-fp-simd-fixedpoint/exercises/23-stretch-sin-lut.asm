; Exercise: 23-stretch-sin-lut
;
; STRETCH: LUT[0]=0 LUT[1]=1; index 1 exit 1.
;
; Contract: implement `ex_23_stretch_sin_lut` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_sin_lut:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_sin_lut in this file.
    call    ex_23_stretch_sin_lut
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
