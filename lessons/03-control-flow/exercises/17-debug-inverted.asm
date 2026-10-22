; Exercise: 17-debug-inverted
;
; BUG: jl used where jg needed. rax=5 should take 'big' path exit 2.
;
; Contract: implement `ex_17_debug_inverted` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_17_debug_inverted:PROC

main PROC
    sub     rsp, 40
    ; BUG: see exercise description; implement fix in student routine.
    ; TODO: write ex_17_debug_inverted in this file.
    call    ex_17_debug_inverted
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
