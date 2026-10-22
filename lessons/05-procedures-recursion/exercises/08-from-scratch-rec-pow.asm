; Exercise: 08-from-scratch-rec-pow
;
; pow(base,exp) recursive. pow(2,5)=32.
;
; Contract: implement `ex_08_from_scratch_rec_pow` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 32
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_rec_pow:PROC

; TODO: write ex_08_from_scratch_rec_pow in this file.

main PROC
    sub     rsp, 40
    call    ex_08_from_scratch_rec_pow
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
