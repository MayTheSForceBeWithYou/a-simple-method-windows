; Exercise: 05-tile-solid
;
; tile id 2 solid table; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_05_tile_solid` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_05_tile_solid:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_05_tile_solid in this file.
    call    ex_05_tile_solid
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
