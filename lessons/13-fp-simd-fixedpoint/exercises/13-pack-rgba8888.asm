; Exercise: 13-pack-rgba8888
;
; R=255 G=0 B=0 A=255; low byte R=255 exit 255.
;
; Contract: implement `ex_13_pack_rgba8888` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 255
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_13_pack_rgba8888:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_13_pack_rgba8888 in this file.
    call    ex_13_pack_rgba8888
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
