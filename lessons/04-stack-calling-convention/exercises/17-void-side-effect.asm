; Exercise: 17-void-side-effect
;
; Write '!' and newline. MS x64 ABI.
; Expected stdout: "!\n"
;
; Contract: implement `ex_17_void_side_effect` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_17_void_side_effect:PROC

; TODO: write ex_17_void_side_effect in this file.

main PROC
    sub     rsp, 40
    call    ex_17_void_side_effect
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
