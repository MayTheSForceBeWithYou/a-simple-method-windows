; Exercise: 12-min-in-array
;
; Same array; min 2.
;
; Contract: implement `ex_12_min_in_array` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 2
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_12_min_in_array:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_12_min_in_array in this file.
    call    ex_12_min_in_array
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
