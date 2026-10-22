; Exercise: 08-from-scratch-stride
;
; Exercise 08: from scratch stride
; FROM SCRATCH: stride=width*bpp; w=16 bpp=4; exit 64.
; Expected stdout: (none)
;
; Contract: implement `ex_08_from_scratch_stride` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 64
;

; 08-from-scratch-stride: from scratch stride
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_stride:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_stride in this file.
    call    ex_08_from_scratch_stride
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
