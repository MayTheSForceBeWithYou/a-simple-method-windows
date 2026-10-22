; Exercise: 20-tile-autotile-mask
;
; Neighbor mask N|E = 5; exit 5.
; Expected stdout: (none)
;
; Contract: implement `ex_20_tile_autotile_mask` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_20_tile_autotile_mask:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_tile_autotile_mask in this file.
    call    ex_20_tile_autotile_mask
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
