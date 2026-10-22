; Exercise: 08-from-scratch-token-buf
;
; Exercise 08: from scratch token buf
; FROM SCRATCH: store ascii 'x' as token lexeme len 1; exit 1.
;
; Contract: implement `ex_08_from_scratch_token_buf` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 1
;

; 08-from-scratch-token-buf
.CODE
EXTRN ExitProcess:PROC
EXTRN ex_08_from_scratch_token_buf:PROC
main PROC
    sub     rsp, 40
    ; TODO: write ex_08_from_scratch_token_buf in this file.
    call    ex_08_from_scratch_token_buf
    mov     ecx, eax
    call    ExitProcess
main ENDP
END
