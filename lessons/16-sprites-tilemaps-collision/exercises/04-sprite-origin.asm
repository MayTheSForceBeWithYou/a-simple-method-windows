; Exercise: 04-sprite-origin
;
; screen = world - camera; 50-20=30.
; Expected stdout: (none)
;
; Contract: implement `ex_04_sprite_origin` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 30
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_04_sprite_origin:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_04_sprite_origin in this file.
    call    ex_04_sprite_origin
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
