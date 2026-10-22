; Exercise: 11-sprite-layer
;
; Sort key layer*1000+y; layer2 y=5 -> 2005&255; exit (2005 & 255)=205? Use exit layer=2.
; Expected stdout: (none)
;
; Contract: implement `ex_11_sprite_layer` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_11_sprite_layer:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_11_sprite_layer in this file.
    call    ex_11_sprite_layer
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
