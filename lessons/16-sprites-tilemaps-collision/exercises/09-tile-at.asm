; Exercise: 09-tile-at
;
; map 4-wide; get(1,1)= tile index 5 stored; exit 5.
; Expected stdout: (none)
;
; Contract: implement `ex_09_tile_at` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 5
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_tile_at:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_tile_at in this file.
    call    ex_09_tile_at
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
