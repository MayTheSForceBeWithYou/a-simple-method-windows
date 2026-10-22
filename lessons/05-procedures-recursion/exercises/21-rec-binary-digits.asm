; Exercise: 21-rec-binary-digits
;
; popcount(0b1101)=3 via recursion. Exit 3.
;
; Contract: implement `ex_21_rec_binary_digits` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 3
;
.CODE
EXTRN ExitProcess:PROC
EXTERNDEF ex_21_rec_binary_digits:PROC



main PROC
    sub     rsp, 40

    ; TODO: write ex_21_rec_binary_digits in this file.
    call    ex_21_rec_binary_digits
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
