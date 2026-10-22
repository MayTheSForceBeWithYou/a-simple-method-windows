; Exercise: 20-steering-seek
;
; Seek desired vel = target-pos; (10-3)=7; exit 7.
; Expected stdout: (none)
;
; Contract: implement `ex_20_steering_seek` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 7
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_20_steering_seek:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_20_steering_seek in this file.
    call    ex_20_steering_seek
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
