; Exercise: 24-debug-signed-div
;
; BUG: used xor rdx,rdx before idiv of negative. Fix with cqo. (-20)/3 quot -6.
;
; Contract: implement `ex_24_debug_signed_div` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 0
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_24_debug_signed_div:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_24_debug_signed_div in this file.
    call    ex_24_debug_signed_div
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
