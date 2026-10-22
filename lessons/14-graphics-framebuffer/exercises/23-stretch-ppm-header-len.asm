; 23-stretch-ppm-header-len: stretch ppm header len
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_ppm_header_len:PROC
main PROC
    ; TODO: write ex_23_stretch_ppm_header_len in this file.
    call    ex_23_stretch_ppm_header_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
