; Exercise: 01-pixel-offset
;
; Exercise 01: pixel offset
; offset=y*stride+x*4; y=2,x=3,stride=40; exit offset&255.
; Expected stdout: (none)
;
; Contract: implement `ex_01_pixel_offset` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 92
;

; 01-pixel-offset: pixel offset
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_01_pixel_offset:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_01_pixel_offset in this file.
    call    ex_01_pixel_offset
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
