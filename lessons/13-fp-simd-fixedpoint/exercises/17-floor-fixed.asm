; Exercise: 17-floor-fixed
;
; Floor Q16.16 3.75 (3<<16 + 49152); exit 3.
;
; Contract: implement `ex_17_floor_fixed` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_17_floor_fixed:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_17_floor_fixed in this file.
    call    ex_17_floor_fixed
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
