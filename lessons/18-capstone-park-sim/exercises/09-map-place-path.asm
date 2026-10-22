; Exercise: 09-map-place-path
;
; Exercise 09: map place path
; Place PATH=1 at (2,3) on w=8; index=3*8+2=26; store; exit cell.
; Expected stdout: (none)
;
; Contract: implement `ex_09_map_place_path` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 09-map-place-path: map place path
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_09_map_place_path:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_09_map_place_path in this file.
    call    ex_09_map_place_path
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
