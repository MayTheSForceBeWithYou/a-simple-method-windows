; Exercise: 16-anim-frame
;
; Exercise 16: anim frame
; frame = (t/ticks)%n; t=10 ticks=4 n=3 -> 2; exit 2.
; Expected stdout: (none)
;
; Contract: implement `ex_16_anim_frame` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;

; 16-anim-frame: anim frame
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_16_anim_frame:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_anim_frame in this file.
    call    ex_16_anim_frame
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
