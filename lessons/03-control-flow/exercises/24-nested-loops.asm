; Exercise: 24-nested-loops
;
; Count pairs (i,j) with 0<=i<3, 0<=j<4 (12). Exit 12.
;
; Contract: implement `ex_24_nested_loops` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 12
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_24_nested_loops:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_24_nested_loops in this file.
    call    ex_24_nested_loops
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
