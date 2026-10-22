; Exercise: 05-mov-chain
;
; Set al=3, bl=5, cl=7. Sum into dil, movzx to rdi, exit (expect 15).
;
; Contract: implement `ex_05_mov_chain` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_05_mov_chain:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_05_mov_chain in this file.
    call    ex_05_mov_chain
    mov     ecx, eax
    call    ExitProcess
    
main ENDP

END
