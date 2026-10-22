; 23-stretch-ppm-header-len: stretch ppm header len
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_ppm_header_len:PROC
main PROC
    ; TODO: implement ex_23_stretch_ppm_header_len (student routine; defined in solutions/).
    call    ex_23_stretch_ppm_header_len
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
