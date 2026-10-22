; 15-camera-cull: camera cull
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_15_camera_cull:PROC
main PROC
    ; TODO: implement ex_15_camera_cull (student routine; defined in solutions/).
    call    ex_15_camera_cull
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
