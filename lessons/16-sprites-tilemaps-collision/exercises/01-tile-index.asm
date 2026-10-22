; Exercise: 01-tile-index
;
; idx=y*map_w+x; y=2 x=3 w=10; exit 23.
; Expected stdout: (none)
;
; Contract: implement `ex_01_tile_index` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 23
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_tile_index:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_tile_index in this file.
    call    ex_01_tile_index
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
