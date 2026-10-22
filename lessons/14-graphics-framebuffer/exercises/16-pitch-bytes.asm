; Exercise: 16-pitch-bytes
;
; pitch=width*4 aligned up to 16: width=5 -> 20 align 32? 20; exit 20.
; Expected stdout: (none)
;
; Contract: implement `ex_16_pitch_bytes` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 20
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_16_pitch_bytes:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_16_pitch_bytes in this file.
    call    ex_16_pitch_bytes
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
