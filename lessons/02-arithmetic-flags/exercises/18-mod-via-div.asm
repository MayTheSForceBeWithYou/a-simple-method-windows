; Exercise: 18-mod-via-div
;
; Compute 42 % 5 using div; exit remainder 2.
;
; Contract: implement `ex_18_mod_via_div` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_18_mod_via_div:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_18_mod_via_div in this file.
    call    ex_18_mod_via_div
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
