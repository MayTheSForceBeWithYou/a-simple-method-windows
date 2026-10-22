; Exercise: 02-place-track
;
; Exercise 02: place track
; Track piece type 3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_02_place_track` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;

; 02-place-track: place track
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_02_place_track:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_place_track in this file.
    call    ex_02_place_track
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
