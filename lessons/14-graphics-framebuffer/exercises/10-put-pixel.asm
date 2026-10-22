; 10-put-pixel: put pixel
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_put_pixel:PROC
main PROC
    ; TODO: implement ex_10_put_pixel (student routine; defined in solutions/).
    call    ex_10_put_pixel
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
