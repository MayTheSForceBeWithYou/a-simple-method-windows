; Exercise: 01-map-cell
;
; Set cell type path=1; exit 1.
; Expected stdout: (none)
;
; Contract: implement `ex_01_map_cell` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_01_map_cell:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_map_cell in this file.
    call    ex_01_map_cell
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
