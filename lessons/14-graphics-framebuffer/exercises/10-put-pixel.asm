; Exercise: 10-put-pixel
;
; put_pixel(x,y) with stride 8 bpp1; x=2 y=1 -> offset 10; store 9; exit 9.
; Expected stdout: (none)
;
; Contract: implement `ex_10_put_pixel` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_10_put_pixel:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_put_pixel in this file.
    call    ex_10_put_pixel
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
