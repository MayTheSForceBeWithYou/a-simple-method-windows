; Exercise: 14-tile-collision-mask
;
; Flags bit0 solid bit1 platform; value 3; exit solid&1 =1.
; Expected stdout: (none)
;
; Contract: implement `ex_14_tile_collision_mask` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_14_tile_collision_mask:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_14_tile_collision_mask in this file.
    call    ex_14_tile_collision_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
