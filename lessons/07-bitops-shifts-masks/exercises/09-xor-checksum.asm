; Exercise: 09-xor-checksum
;
; XOR-fold bytes 1,2,4,8 -> 15.
;
; Contract: implement `ex_09_xor_checksum` (MS x64). Return exit code in EAX; main passes it to ExitProcess.
; Expected exit: 15
;
.DATA
bytes DB 12h, 34h, 56h, 78h
bytes_len EQU $ - bytes

.CODE

EXTRN ExitProcess:PROC
EXTRN ex_09_xor_checksum:PROC

main PROC
    sub     rsp, 40
    ; TODO: write ex_09_xor_checksum in this file.
    call    ex_09_xor_checksum
    mov     ecx, eax
    call    ExitProcess
main ENDP

END
