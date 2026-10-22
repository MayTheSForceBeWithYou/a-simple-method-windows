; Exercise: 06-ack-lite
;
; ack(1,1) = 3. MS x64 ABI.
;
; Contract: implement `ex_06_ack_lite` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_06_ack_lite:PROC

; TODO: write ex_06_ack_lite in this file.

main PROC
    sub     rsp, 40
    call    ex_06_ack_lite
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
