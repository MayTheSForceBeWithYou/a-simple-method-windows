; 02-pack-rgb: pack rgb
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_pack_rgb:PROC
main PROC
    ; TODO: write ex_02_pack_rgb in this file.
    call    ex_02_pack_rgb
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
