; Exercise: 26-debug-bss-read
;
; BUG: reads .data? before store (0). Store 12 first; exit 12.
;
; Contract: implement `ex_26_debug_bss_read` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.DATA?
v QWORD ?

.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_26_debug_bss_read:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_26_debug_bss_read in this file.
    call    ex_26_debug_bss_read
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
