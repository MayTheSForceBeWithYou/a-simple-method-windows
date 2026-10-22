; Exercise: 21-gray-code
;
; Implement `ex_21_gray_code` in this file.
;
; Contract: implement `ex_21_gray_code` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 4
;
.CODE

EXTRN ExitProcess:PROC
EXTERNDEF ex_21_gray_code:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_21_gray_code in this file.
    call    ex_21_gray_code
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
