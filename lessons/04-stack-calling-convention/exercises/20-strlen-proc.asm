; Exercise: 20-strlen-proc
;
; strlen('assembly')=8. MS x64 ABI.
;
; Contract: implement `ex_20_strlen_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 8
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_20_strlen_proc:PROC

; TODO: write ex_20_strlen_proc in this file.

main PROC
    sub     rsp, 40
    call    ex_20_strlen_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
