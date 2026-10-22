; Exercise: 15-camera-cull
;
; Sprite x=100 cam=50 view_w=40 -> culled; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_15_camera_cull` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_15_camera_cull:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_15_camera_cull in this file.
    call    ex_15_camera_cull
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
