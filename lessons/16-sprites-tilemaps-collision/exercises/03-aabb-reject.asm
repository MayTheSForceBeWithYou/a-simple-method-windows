; Exercise: 03-aabb-reject
;
; No overlap -> 0.
; Expected stdout: (none)
;
; Contract: implement `ex_03_aabb_reject` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_03_aabb_reject:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_03_aabb_reject in this file.
    call    ex_03_aabb_reject
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
