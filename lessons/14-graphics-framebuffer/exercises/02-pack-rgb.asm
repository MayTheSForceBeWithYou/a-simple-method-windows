; Exercise: 02-pack-rgb
;
; Pack R=1,G=2,B=3 into 0010203h then &255 exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_02_pack_rgb` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_02_pack_rgb:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_02_pack_rgb in this file.
    call    ex_02_pack_rgb
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
