; Exercise: 21-atan2-stub
;
; Exercise 21: atan2 stub
; Stub: angle for (0,1) as 90 degrees; exit 90.
;
; Contract: implement `ex_21_atan2_stub` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 90
;

; 21-atan2-stub.asm: Stub: atan2 approximation, exit angle
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_21_atan2_stub:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_21_atan2_stub in this file.
    call    ex_21_atan2_stub
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
