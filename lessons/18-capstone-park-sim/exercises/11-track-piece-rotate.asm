; Exercise: 11-track-piece-rotate
;
; Exercise 11: track piece rotate
; Rotate piece dir 0..3; 3+1 -> 0; exit 0.
; Expected stdout: (none)
;
; Contract: implement `ex_11_track_piece_rotate` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;

; 11-track-piece-rotate: track piece rotate
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_11_track_piece_rotate:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_track_piece_rotate in this file.
    call    ex_11_track_piece_rotate
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
