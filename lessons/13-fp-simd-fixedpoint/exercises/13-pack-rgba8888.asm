; 13-pack-rgba8888
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_13_pack_rgba8888:PROC
main PROC
    ; TODO: write ex_13_pack_rgba8888 in this file.
    call    ex_13_pack_rgba8888
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
