; 15-camera-cull: camera cull
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_camera_cull:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_camera_cull in this file.
    call    ex_15_camera_cull
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
