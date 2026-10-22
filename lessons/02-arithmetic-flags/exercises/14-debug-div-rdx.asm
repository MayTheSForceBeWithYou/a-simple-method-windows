; Exercise: 14-debug-div-rdx
;
; BUG: forgot xor rdx,rdx before div. Fix; 100/10 quot exit 10.
;
; Contract: implement `ex_14_debug_div_rdx` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 10
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_14_debug_div_rdx:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_14_debug_div_rdx in this file.
    call    ex_14_debug_div_rdx
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
