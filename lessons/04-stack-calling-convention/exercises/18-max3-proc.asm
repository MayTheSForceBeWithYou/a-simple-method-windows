; Exercise: 18-max3-proc
;
; max3(3,9,7)=9. MS x64 ABI.
;
; Contract: implement `ex_18_max3_proc` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 9
;
.CODE

EXTRN ExitProcess:PROC
EXTRN ex_18_max3_proc:PROC

; TODO: write ex_18_max3_proc in this file.

main PROC
    sub     rsp, 40
    call    ex_18_max3_proc
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
