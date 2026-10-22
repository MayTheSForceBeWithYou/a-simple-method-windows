; Exercise: 10-world-to-tile
;
; world x=20 tile_size=8 -> tile 2; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_10_world_to_tile` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_world_to_tile:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_world_to_tile in this file.
    call    ex_10_world_to_tile
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
