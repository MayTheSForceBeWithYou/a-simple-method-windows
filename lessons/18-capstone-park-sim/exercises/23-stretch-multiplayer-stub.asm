; Exercise: 23-stretch-multiplayer-stub
;
; Exercise 23: stretch multiplayer stub
; STRETCH: net tick id 2; exit 2. (local stub)
; Expected stdout: (none)
;
; Contract: implement `ex_23_stretch_multiplayer_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 23-stretch-multiplayer-stub: stretch multiplayer stub
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_23_stretch_multiplayer_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_23_stretch_multiplayer_stub in this file.
    call    ex_23_stretch_multiplayer_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
