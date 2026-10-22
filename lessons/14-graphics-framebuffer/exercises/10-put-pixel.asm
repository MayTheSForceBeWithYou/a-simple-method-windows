; 10-put-pixel: put pixel
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_put_pixel:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_put_pixel in this file.
    call    ex_10_put_pixel
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
