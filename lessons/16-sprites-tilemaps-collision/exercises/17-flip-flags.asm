; Exercise: 17-flip-flags
;
; HFLIP|VFLIP = 3; exit 3.
; Expected stdout: (none)
;
; Contract: implement `ex_17_flip_flags` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_flip_flags:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_flip_flags in this file.
    call    ex_17_flip_flags
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
