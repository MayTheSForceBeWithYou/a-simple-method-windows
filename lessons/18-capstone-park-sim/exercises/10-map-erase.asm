; Exercise: 10-map-erase
;
; Exercise 10: map erase
; Erase cell to EMPTY=0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_10_map_erase` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 10-map-erase: map erase
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_10_map_erase:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_10_map_erase in this file.
    call    ex_10_map_erase
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
