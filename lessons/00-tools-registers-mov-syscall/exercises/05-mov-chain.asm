; Exercise: 05-mov-chain
;
; Set AL=3, BL=5, CL=7. Sum into AL, movzx to RCX, exit (expect 15).
;
; Contract: implement `ex_05_mov_chain` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_05_mov_chain:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_mov_chain in this file.
    call    ex_05_mov_chain
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
