; 02-pack-rgb: pack rgb
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_pack_rgb:PROC
main PROC
    ; TODO: implement ex_02_pack_rgb (student routine; defined in solutions/).
    call    ex_02_pack_rgb
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
